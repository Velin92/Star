//
//  ProductDetailViewModel.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 20/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    func loadView()
}

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    weak var view: ProductDetailViewProtocol!
    var interactor: ProductDetailInteractorProtocol
    var viewState = ProductDetailViewState()
    
    init(view: ProductDetailViewProtocol, interactor: ProductDetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func loadView() {
        interactor.loadProductAdditionalDetails()
        interactor.loadImages() { [weak self] datas in
            self?.viewState.imageDatas = datas
            self?.updateViewState()
        }
    }
    
    private func updateViewState() {
        view.viewState = viewState
    }
    
}
