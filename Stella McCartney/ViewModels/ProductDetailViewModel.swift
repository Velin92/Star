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
    var viewState = ProductDetailViewState(modelName: "", fullPrice: 0)
    
    init(view: ProductDetailViewProtocol, interactor: ProductDetailInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func loadView() {
        let product = interactor.product
        viewState = ProductDetailViewState(modelName: product.modelNames!, fullPrice: product.fullPrice!, discountedPrice: product.discountedPrice)
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
