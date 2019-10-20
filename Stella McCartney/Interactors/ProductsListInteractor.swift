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
    let service: ProductsListAPIClient
    var products = [String:Product]()
    
    var imageDownloadedClosure: ((String, Data) -> Void)?

    init(of type: ProductsListType, service: ProductsListAPIClient) {
        self.type = type
        self.service = service
    }
    
    func loadProductsList(completion: @escaping ((Result<[Product], ProductsListError>)->Void)){
        service.productsList(of: type) { [weak self] result in
            switch result {
            case .success(let productsListResponse):
                guard productsListResponse.header?.statusCode == 200,
                let products = productsListResponse.resultsLite?.items else {
                    completion(.failure(.genericError))
                    return
                }
                products.forEach { product in
                    if let productId = product.code8 {
                        self?.products[productId] = product
                        self?.saveImage(for: productId, of: product)
                    }
                }
                completion(.success(products))
            case .failure:
                completion(.failure(.genericError))
            }
        }
    }
    
    private func saveImage(for key: String, of product: Product) {
        guard let imageCode = product.defaultCode10, let productId = product.code8 else {return}
        let baseUrl = "https://www.stellamccartney.com/"
        let folderId = imageCode.prefix(2)
        let resolution = "8"
        let type = "c"
        let urlPath = "\(baseUrl)\(folderId)/\(imageCode)_\(resolution)_\(type).jpg"
        print(urlPath)
        guard let url = URL(string: urlPath) else {
            fatalError("Url is not formatted in the right way")
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                self?.imageDownloadedClosure?(productId, data)
            }
        }
    }
    
    func getProduct(for productId: String) -> Product {
        guard let product = products[productId] else {
            fatalError("The mapping algorithm has something wrong")
        }
        return product
    }
}
