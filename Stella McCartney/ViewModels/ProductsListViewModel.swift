//
//  ProductsListViewModel.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

protocol ProductsListViewModelProtocol {
    func loadProductsList()
}

class ProductsListViewModel: ProductsListViewModelProtocol {
    
    weak var view: ProductsListViewProtocol!
    let interactor: ProductsListInteractorProtocol
    var viewState = ProductsListViewState(productSections: [])
    
    init(view: ProductsListViewProtocol, interactor: ProductsListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func loadProductsList() {
        interactor.loadProductsList() { [weak self] result in
            switch result {
            case .success(let products):
                self?.updateViewState(with: products)
                break
            case .failure:
                break
            }
        }
    }
    
    private func updateViewState(with products: [Product]) {
        let sectionsSet = Set(products.compactMap {$0.microCategory})
        let orderedSections = sectionsSet.map{$0}.sorted()
        orderedSections.forEach { section in
            let productsOfSection = products.filter {$0.microCategory == section}
            let productsViewState = productsOfSection.compactMap {ProductViewState(name: $0.modelNames, price: $0.fullPrice)}.sorted(by: {$0.name < $1.name})
            viewState.productSections.append(ProductsSectionViewState(name: section, products: productsViewState))
        }
        self.view.viewState = self.viewState
    }
}
