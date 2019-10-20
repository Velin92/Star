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
    func selectedProduct(at index: Int, in section: Int)
}

class ProductsListViewModel: ProductsListViewModelProtocol {
    
    weak var view: ProductsListViewProtocol!
    var interactor: ProductsListInteractorProtocol
    var viewState = ProductsListViewState(productSections: [])
    var viewIndexesToProductId : [IndexPath: String] = [:]
    
    init(view: ProductsListViewProtocol, interactor: ProductsListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.configureInteractor()
    }
    
    func loadProductsList() {
        interactor.loadProductsList() { [weak self] result in
            switch result {
            case .success(let products):
                self?.populateViewModel(with: products)
                self?.updateViewState()
            case .failure:
                break
            }
        }
    }
    
    private func configureInteractor() {
        interactor.imageDownloadedClosure = { [weak self] productId, data in
            guard let indexPath = self?.viewIndexesToProductId.first(where: {$0.value == productId})?.key else {
                return
            }
            self?.viewState.productSections[indexPath.section].products[indexPath.item].imageData = data
            self?.updateViewState()
        }
    }
        
    private func populateViewModel(with products: [Product]) {
        let sectionsSet = Set(products.compactMap {$0.microCategory})
        let orderedSections = sectionsSet.map{$0}.sorted()
        orderedSections.enumerated().forEach { (sectionIndex,section) in
            let orderedProductsOfSection = products.filter {$0.microCategory == section && $0.modelNames != nil}.sorted(by: {$0.modelNames! <= $1.modelNames!})
            var productsViewState = [ProductViewState]()
            orderedProductsOfSection.enumerated().forEach { (arg) in
                let (productIndex, product) = arg
                viewIndexesToProductId[IndexPath(item: productIndex, section: sectionIndex)] = product.code8
                productsViewState.append(ProductViewState(name: product.modelNames!, price: product.fullPrice))
            }
            viewState.productSections.append(ProductsSectionViewState(name: section, products: productsViewState))
        }
    }
    
    private func updateViewState() {
        self.view.viewState = viewState
    }
    
    func selectedProduct(at index: Int, in section: Int){
        let indexPath = IndexPath(item: index, section: section)
        print(viewIndexesToProductId[indexPath])
    }
    
    
}
