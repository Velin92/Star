//
//  ProductsListTableViewController.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 18/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol ProductsListViewProtocol {
    
}

class ProductsListTableViewController: UITableViewController, Storyboarded {
    
    //TO DO: Move in a an appropriated class, just used to test the services

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductsListTableViewController.productsList { result in
            switch result {
            case .success(let productsList):
                print(productsList)
            case .failure(let error):
                print(error)
            }
        }
    }
        
    static func productsList(completion: @escaping (AFResult<ProductsListResponse>) -> Void)
    {
      let locationRequest = ProductsListRequest(ave: "prod", productsPerPage: 50, gender: "D", page: 1, department: "Main_Ready_To_Wear", format: "lite", sortRule: "Ranking")
        request(ApiRouter.productsList(productsListRequest: locationRequest), completion: completion)
    }

    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible,
                                             completion: @escaping (AFResult<T>) -> Void)
    {
      AF.request(urlConvertible).responseData(completionHandler:{ (dataResponse: AFDataResponse<Data>) in
        printReposne(response: dataResponse)
        let decoder = JSONDecoder()
        let response: AFResult<T> = decoder.decodeResponse(from: dataResponse)
        completion(response)
      })
    }
    
    private static func printReposne(response: AFDataResponse<Data>)
    {
        guard let value = response.value,
        let string = NSString(data: value, encoding: String.Encoding.utf8.rawValue)
        else { return }
      
      print("response is:\n \(string)")
    }
    
}

extension ProductsListTableViewController: ProductsListViewProtocol {
    
}
