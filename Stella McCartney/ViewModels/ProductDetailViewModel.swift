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
    var viewState: ProductDetailViewState
    
    init(view: ProductDetailViewProtocol, interactor: ProductDetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        let product = interactor.product
        self.viewState = ProductDetailViewState(modelName: product.modelNames!, macroCategory: product.macroCategory!, microCategory: product.microCategory!, fullPrice: product.fullPrice!, discountedPrice: product.discountedPrice)
    }
    
    func loadView() {
        updateViewState()
        interactor.loadImages() { [weak self] datas in
            self?.viewState.imageDatas = datas
            self?.updateViewState()
        }
        interactor.loadProductAdditionalDetails { [weak self] result in
            switch result {
            case .success(let productDetail):
                if let colors = productDetail.modelColors {
                    print(colors)
                    self?.viewState.colors = colors.compactMap { color in
                        guard let colorName = color.colorDescription, let rgbColor = color.rgb else{
                            return nil
                        }
                        return ProductColorViewState(colorName: colorName, rgbColor: rgbColor)
                    }
                }
                self?.updateViewState()
            case .failure:
                break
            }
        }
    }
    
    private func updateViewState() {
        view.viewState = viewState
    }
}
