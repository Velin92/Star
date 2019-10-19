//
//  ProductsListViewModel.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

protocol ProductsListViewModelProtocol {
    
}

class ProductsListViewModel: ProductsListViewModelProtocol {
    
    weak var view: ProductsListViewProtocol!
    let interactor: ProductsListInteractorProtocol
    
    init(view: ProductsListViewProtocol, interactor: ProductsListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
}
