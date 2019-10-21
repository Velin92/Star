//
//  ProductsListInteractor.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

enum ProductsListError: Error {
    case genericError
}

protocol ProductsListInteractorProtocol {
    
    func loadProductsList(completion: @escaping ((Result<[Product], ProductsListError>)->Void))
    var imageDownloadedClosure: ((String,Data) -> Void)? {get set}
    func getProduct(for productId: String) -> Product
}

class ProductsListInteractor: ProductsListInteractorProtocol {
    
    let type: ProductsListType
    let apiService: ProductsListAPIClient
    let imageService: ProductsListImageService
    var products = [String:Product]()
    
    var imageDownloadedClosure: ((String, Data) -> Void)?

    init(of type: ProductsListType, apiService: ProductsListAPIClient, imageService: ProductsListImageService) {
        self.type = type
        self.apiService = apiService
        self.imageService = imageService
    }
    
    func loadProductsList(completion: @escaping ((Result<[Product], ProductsListError>)->Void)){
        apiService.productsList(of: type) { [weak self] result in
            switch result {
            case .success(let productsListResponse):
                guard productsListResponse.header?.statusCode == 200,
                let products = productsListResponse.resultsLite?.items else {
                    completion(.failure(.genericError))
                    return
                }
                let identifiableProducts = products.filter {$0.code8 != nil}
                completion(.success(identifiableProducts))
                identifiableProducts.forEach { product in
                    if let productId = product.code8 {
                        self?.products[productId] = product
                        self?.saveImage(for: productId, of: product)
                    }
                }
            case .failure:
                completion(.failure(.genericError))
            }
        }
    }
    
    private func saveImage(for key: String, of product: Product) {
        guard let imageCode = product.defaultCode10, let productId = product.code8 else {return}
        imageService.loadImage(for: imageCode, imageType: .front, pixels: 101) { [weak self] data in
            self?.imageDownloadedClosure?(productId, data)
        }
    }
    
    func getProduct(for productId: String) -> Product {
        guard let product = products[productId] else {
            fatalError("The mapping algorithm has something wrong")
        }
        return product
    }
}
