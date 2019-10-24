//
//  APIClientMock.swift
//  Stella McCartneyTests
//
//  Created by Mauro Romito on 23/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
@testable import Alamofire
@testable import Stella_McCartney

class APIClientMock: ProductsListAPIClient, ProductDetailAPIClient {
    
    var productDetailResponse: ProductDetailResponse!
    var productListResponse: ProductsListResponse!
    var isFailureTest = false
    
    func productsList(of type: ProductsListType, completion: @escaping (AFResult<ProductsListResponse>) -> Void) {
        if !isFailureTest {
            completion(AFResult<ProductsListResponse>.success(productListResponse))
        } else {
            completion(AFResult<ProductsListResponse>.failure(AFError.sessionTaskFailed(error: "a")))
        }
    }
    
    func productDetail(for productId: String, completion: @escaping (AFResult<ProductDetailResponse>) -> Void) {
        if !isFailureTest {
            completion(AFResult<ProductDetailResponse>.success(productDetailResponse))
        } else {
            completion(AFResult<ProductDetailResponse>.failure(AFError.sessionTaskFailed(error: "a")))
        }
    }
}

extension String:Error {
    
}

