//
//  APIClient.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import Alamofire

protocol ProductsListAPIClient {
    static func productsList(of type: ProductsListType, completion: @escaping (AFResult<ProductsListResponse>) -> Void)
}

struct APIClient {
    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible, completion: @escaping (AFResult<T>) -> Void) {
        AF.request(urlConvertible).responseData(completionHandler:{ (dataResponse: AFDataResponse<Data>) in
            printReposne(response: dataResponse)
            let decoder = JSONDecoder()
            let response: AFResult<T> = decoder.decodeResponse(from: dataResponse)
            completion(response)
        })
    }
    
    private static func printReposne(response: AFDataResponse<Data>) {
        guard let value = response.value,
            let string = NSString(data: value, encoding: String.Encoding.utf8.rawValue)
            else { return }
        
        print("response is:\n \(string)")
    }
}

extension APIClient: ProductsListAPIClient {
    
    static func productsList(of type: ProductsListType, completion: @escaping (AFResult<ProductsListResponse>) -> Void) {
        let locationRequest = ProductsListRequest(ave: "prod", productsPerPage: 50, gender: "D", page: 1, department: "Main_Ready_To_Wear", format: "lite", sortRule: "Ranking")
        request(APIRouter.productsList(productsListRequest: locationRequest), completion: completion)
    }
}
