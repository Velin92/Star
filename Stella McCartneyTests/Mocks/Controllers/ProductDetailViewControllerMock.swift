//
//  ProductDetailViewControllerMock.swift
//  Stella McCartneyTests
//
//  Created by Mauro Romito on 24/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import UIKit
@testable import Stella_McCartney

class ProductDetailViewControllerMock: UIViewController, ProductDetailViewProtocol {
    var viewState: ProductDetailViewState = ProductDetailViewState(modelName: "", macroCategory: "", microCategory: "", fullPrice: 0)
    
    
}
