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
        setLoadingState()
        interactor.loadImages() { [weak self] datas in
            self?.updateImageSates(from: datas)
        }
        interactor.loadProductAdditionalDetails { [weak self] result in
            switch result {
            case .success(let productDetail):
                if let colors = productDetail.modelColors {
                    print(colors)
                    self?.updateColors(colors)
                }
                if let sizes = productDetail.modelSizes {
                    print(sizes)
                    self?.updateSizes(sizes)
                }
                self?.viewState.additionalInfoState = .ready
                self?.updateViewState()
            case .failure:
                self?.viewState.additionalInfoState = .missing
                self?.updateViewState()
            }
        }
    }
        
    private func updateImageSates(from datas: [Data]) {
        if datas.isEmpty {
            viewState.imageStates = [.notFound]
        } else {
            viewState.imageStates = datas.map{ImageStates.imageFound(imageData: $0)}
        }
        updateViewState()
    }
        
    private func updateColors(_ colors: [ModelColor] ) {
        viewState.colors = colors.compactMap { color in
            guard let colorName = color.colorDescription, let rgbColor = color.rgb else{
                return nil
            }
            return ProductColorViewState(colorName: colorName, rgbColor: rgbColor)
        }
    }
    
    private func updateSizes(_ sizes: [ModelSize]) {
        self.viewState.sizes = sizes.compactMap { size in
            guard let sizeValue = size.modelSizeDefault?.text, let sizeMetric = size.modelSizeDefault?.classFamily else {
                return nil
            }
            return ProductSizeViewState(size: sizeValue, metric: sizeMetric)
        }
    }
    
    private func updateViewState() {
        view.viewState = viewState
    }
    
    private func setLoadingState() {
        viewState.imageStates = [.imageLoading]
        viewState.additionalInfoState = .notReady
        updateViewState()
    }
}
