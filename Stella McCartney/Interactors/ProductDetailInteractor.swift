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
    func loadProductAdditionalDetails()
    func loadImages(completion: @escaping (([Data])-> Void))
}

class ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    let apiService: ProductDetailAPIClient
    let imageService: ProductDetailImageService
    
    //I know for sure that this product has at least code8, modelNames, microCategory and fullPrice
    let product: Product
    
    init(product: Product, apiService: ProductDetailAPIClient, imageService: ProductDetailImageService) {
        self.product = product
        self.apiService = apiService
        self.imageService = imageService
    }
    
    func loadProductAdditionalDetails() {
        apiService.productDetail(for: product.code8!) { result in
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
    
    func loadImages(completion: @escaping (([Data]) -> Void)) {
        guard let imageCode =  product.defaultCode10 else {
            return completion([])
        }
        imageService.loadAllImages(for: imageCode, pixels: 101) { results in
            let datas = results.sorted {$0.key < $1.key}.map {$0.value}
            completion(datas)
        }
    }
}
