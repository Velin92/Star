//
//  ProducstListRequest.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

struct ProductsListRequest: Codable {
    let ave: String
    let productsPerPage: Int
    let gender: String?
    let page: Int
    let department: String
    let format: String
    let sortRule: String
}
