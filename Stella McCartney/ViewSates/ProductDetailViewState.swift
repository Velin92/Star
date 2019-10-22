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
    var modelName: String
    var fullPrice: Int
    
    init(modelName: String, fullPrice: Int) {
        self.modelName = modelName
        self.fullPrice = fullPrice
    }
    
    var formattedFullPrice: String {
        return "\(fullPrice)€"
    }
    
}
