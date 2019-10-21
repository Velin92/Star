//
//  APIConstants.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

enum HTTPHeaderField: String {
  case authentication = "Authorization"
  case contentType = "Content-Type"
  case acceptType = "Accept"
  case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
  case json = "application/json"
}
