//
//  ProductDetailViewModel.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 20/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    func loadAdditionalDetails()
}

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    weak var view: ProductDetailViewProtocol!
    var interactor: ProductDetailInteractorProtocol
    
    init(view: ProductDetailViewProtocol, interactor: ProductDetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func loadAdditionalDetails(){
        interactor.loadProductDetail()
    }
}
