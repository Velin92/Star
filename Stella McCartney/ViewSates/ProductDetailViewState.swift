//
//  ProductDetailViewState.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 21/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

struct ProductDetailViewState {
    
    var imageDatas = [Data]()
    let modelName: String
    private let fullPrice: Int
    private let discountedPrice: Int
    let isDiscounted: Bool
    var colors = [ProductColorViewState]()
    
    init(modelName: String, fullPrice: Int, discountedPrice: Int? = nil) {
        self.modelName = modelName
        self.fullPrice = fullPrice
        if let discountedPrice = discountedPrice {
            self.isDiscounted = discountedPrice < fullPrice
            self.discountedPrice = discountedPrice
        } else {
            self.isDiscounted = false
            self.discountedPrice = 0
        }
    }
    
    var formattedFullPrice: String {
        return "\(fullPrice)€"
    }
    
    var formattedDiscountedPrice: String {
        return "\(discountedPrice)€"
    }
}
