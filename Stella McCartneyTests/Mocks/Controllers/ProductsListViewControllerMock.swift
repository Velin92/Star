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
    
    var viewState: ProductsListViewState = ProductsListViewState(productSections: [])
    var product: Product?
}

extension ProductsListViewControllerMock: ProductsListViewProtocol {
    
    func goToProductDetail(for product: Product) {
        self.product = product
    }
}
