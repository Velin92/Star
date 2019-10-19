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
    func productsList(of type: ProductsListType, completion: @escaping (AFResult<ProductsListResponse>) -> Void)
}

class APIClient {
    
    private func request<T: Codable> (_ urlConvertible: URLRequestConvertible, completion: @escaping (AFResult<T>) -> Void) {
        AF.request(urlConvertible).responseData(completionHandler:{ (dataResponse: AFDataResponse<Data>) in
            //self?.printResponse(response: dataResponse)
            let decoder = JSONDecoder()
            let response: AFResult<T> = decoder.decodeResponse(from: dataResponse)
            completion(response)
        })
    }
    
    private func printResponse(response: AFDataResponse<Data>) {
        guard let value = response.value,
            let string = NSString(data: value, encoding: String.Encoding.utf8.rawValue)
            else { return }
        
        print("response is:\n \(string)")
    }
}

extension APIClient: ProductsListAPIClient {
    
    func productsList(of type: ProductsListType, completion: @escaping (AFResult<ProductsListResponse>) -> Void) {
        let productsListRequest = getRequest(from: type)
        request(APIRouter.productsList(productsListRequest: productsListRequest), completion: completion)
    }
    
    func getRequest(from type: ProductsListType) -> ProductsListRequest {
        switch type {
        case .accessories:
            return ProductsListRequest(ave: "prod", productsPerPage: 50, gender: "D", page: 1, department: "Main_Accessories_All", format: "lite", sortRule: "Ranking")
        case .readyToWear:
            return ProductsListRequest(ave: "prod", productsPerPage: 50, gender: "D", page: 1, department: "Main_Ready_To_Wear", format: "lite", sortRule: "Ranking")
        case .beauty:
            return ProductsListRequest(ave: "prod", productsPerPage: 50, gender: "D", page: 1, department: "Main_Beauty", format: "lite", sortRule: "Ranking")
        case .lingerie:
            return ProductsListRequest(ave: "prod", productsPerPage: 50, gender: nil, page: 1, department: "Main_Lingerie", format: "lite", sortRule: "Ranking")
            
        }
    }
}
