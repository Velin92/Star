//
//  ProductsListViewControllerMock.swift
//  Stella McCartneyTests
//
//  Created by Mauro Romito on 23/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import UIKit
@testable import Stella_McCartney

class ProductsListViewControllerMock: UIViewController {
    var errorScreenIsShown = false
    var viewState: ProductsListViewState = ProductsListViewState(productSections: [])
    var product: Product?
}

extension ProductsListViewControllerMock: ProductsListViewProtocol, LoaderDisplayer {
    
    func showErrorView() {
        errorScreenIsShown = true
    }
    
    func goToProductDetail(for product: Product) {
        self.product = product
    }
}
