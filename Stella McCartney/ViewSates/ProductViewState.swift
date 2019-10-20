//
//  ProductModel.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

struct ProductViewState {
    
    let name: String
    private let price: Int
    var imageData: Data? = nil
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
    
    var formattedPrice: String {
        get {
            return "\(price)€"
        }
    }
}
