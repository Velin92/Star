//
//  ProductSizeViewState.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 22/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

struct ProductSizeViewState {
    
    private let size: String
    private let metric: String
    
    init(size: String, metric: String) {
        self.size = size
        self.metric = metric
    }
    
    var formattedSize: String {
        return "\(size) \(metric)"
    }
}
