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
    
    typealias ProductsListView = ProductsListViewProtocol & LoaderDisplayer
    weak var view: ProductsListView!
    var interactor: ProductsListInteractorProtocol
    var viewState = ProductsListViewState(productSections: [])
    var viewIndexesToProductId : [IndexPath: String] = [:]
    
    init(view: ProductsListView, interactor: ProductsListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.configureInteractor()
    }
    
    func loadProductsList() {
        view.showLoader()
        interactor.loadProductsList() { [weak self] result in
            self?.view.hideLoader()
            switch result {
            case .success(let products):
                self?.populateViewModel(with: products)
                self?.updateViewState()
            case .failure:
                self?.view.showErrorView()
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
    
    //the products in this func have already been validated so code8, name, microCategory, macroCategory and fullPrice are not nil
    private func populateViewModel(with products: [Product]) {
        var isMacroSorted = true
        var sectionsSet = Set(products.compactMap {$0.macroCategory})
        if sectionsSet.count <= 1 {
            isMacroSorted = false
            sectionsSet = Set(products.compactMap {$0.microCategory})
        }
        let orderedSections = sectionsSet.map{$0}.sorted()
        orderedSections.enumerated().forEach { (sectionIndex,section) in
            let filteredProductsOfSection = products.filter {
                isMacroSorted ? $0.macroCategory == section : $0.microCategory == section
            }
            let orderedProductsOfSection = filteredProductsOfSection.sorted(by: {$0.modelNames! <= $1.modelNames!})
            var productsViewState = [ProductViewState]()
            orderedProductsOfSection.enumerated().forEach { (arg) in
                let (productIndex, product) = arg
                viewIndexesToProductId[IndexPath(item: productIndex, section: sectionIndex)] = product.code8
                var price = product.fullPrice!
                if let discountedPrice = product.discountedPrice, discountedPrice < price {
                    price = discountedPrice
                }
                productsViewState.append(ProductViewState(name: product.modelNames!, price: price))
            }
            viewState.productSections.append(ProductsSectionViewState(name: section, products: productsViewState))
        }
    }
    
    private func updateViewState() {
        self.view.viewState = viewState
    }
    
    func selectedProduct(at index: Int, in section: Int){
        let indexPath = IndexPath(item: index, section: section)
        guard let productId = viewIndexesToProductId[indexPath] else {
            fatalError("The mapping algorithm has something wrong")
        }
        let product = interactor.getProduct(for: productId)
        view.goToProductDetail(for: product)
    }
}
