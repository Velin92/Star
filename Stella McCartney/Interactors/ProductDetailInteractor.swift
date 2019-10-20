//
//  ProductDetailInteractor.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 20/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

enum ProductDetailError: Error {
    case genericError
}

protocol ProductDetailInteractorProtocol {
    func loadProductDetail()
}

class ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    let service: ProductDetailAPIClient
    
    //I know for sure that this product has at least code8, modelNames, microCategory and fullPrice
    let product: Product
    
    init(product: Product, service: ProductDetailAPIClient) {
        self.product = product
        self.service = service
    }
    
    func loadProductDetail() {
        service.productDetail(for: product.code8!) { result in
            switch result {
            case .success(let productDetailResponse):
                guard productDetailResponse.header?.statusCode == 200,
                    let productDetail = productDetailResponse.item else {
                        return
                }
                print(productDetail)
            case .failure:
                break
            }
        }
    }
}
