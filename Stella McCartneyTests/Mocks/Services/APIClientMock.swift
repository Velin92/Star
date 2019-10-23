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
    
    var productListResponse: ProductsListResponse!
    var isFailureTest = false
    
    var numberOfElements: Int {
        return productListResponse.resultsLite!.totalResults!
    }
    
    func productsList(of type: ProductsListType, completion: @escaping (AFResult<ProductsListResponse>) -> Void) {
        if !isFailureTest {
            completion(AFResult<ProductsListResponse>.success(productListResponse))
        } else {
            completion(AFResult<ProductsListResponse>.failure(AFError.sessionTaskFailed(error: "a")))
        }
    }
    
    func productDetail(for productId: String, completion: @escaping (AFResult<ProductDetailResponse>) -> Void) {
        
    }
    
}

extension String:Error {
    
}

