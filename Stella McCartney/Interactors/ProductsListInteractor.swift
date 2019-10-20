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
}

class ProductsListInteractor: ProductsListInteractorProtocol {
    
    let type: ProductsListType
    let service: ProductsListAPIClient
    var products = [String:Product]()
    
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
                    self?.products[product.code8] = product
                }
                completion(.success(products))
            case .failure:
                completion(.failure(.genericError))
            }
        }
    }
}
