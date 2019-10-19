//
//  ProductsListInteractor.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

protocol ProductsListInteractorProtocol {
    
}

class ProductsListInteractor: ProductsListInteractorProtocol {
    
    let type: ProductsListType
    
    init(of type: ProductsListType) {
        self.type = type
    }
    
}
