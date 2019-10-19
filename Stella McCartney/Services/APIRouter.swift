//
//  RestClient.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 18/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import Alamofire

enum Constants {
  static let baseURLPath = "https://api.yoox.biz"
}

enum APIRouter: URLRequestConvertible {
  case productsList(productsListRequest: ProductsListRequest)
  
  var method: HTTPMethod {
    switch self
    {
    case .productsList:
      return .get
    }
  }
  
  var path: String {
    switch self
    {
    case .productsList:
      return "/Search.API/1.3/SMC_IT/search/results.json"
    }
  }
  
  var encoding: ParameterEncoding {
    switch method
    {
    case .get:
      return URLEncoding.default
    default:
      return JSONEncoding.default
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    let url = try Constants.baseURLPath.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    // HTTP Method
    urlRequest.httpMethod = method.rawValue
    
    // Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    if method == .post {
        let codable: Any = getConcreteCodables()
        do
        {
          urlRequest.httpBody = try JSONSerialization.data(withJSONObject: codable, options: .prettyPrinted)
        }
        catch
        {
          throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
      return urlRequest
    } else {
      switch self {
      case .productsList(let productsListRequest):
         urlRequest = try URLEncodedFormParameterEncoder.default.encode(productsListRequest, into: urlRequest)
      }
      print("GET request url\n: \(String(describing: urlRequest.url?.absoluteString))")
      return urlRequest
    }
  }

  private func getConcreteCodables() -> Any {
    switch self {
    case .productsList(let productsListRequest):
      return productsListRequest
    }
  }
}
