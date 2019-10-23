//
//  MenuViewControllerMock.swift
//  Stella McCartneyTests
//
//  Created by Mauro Romito on 23/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import UIKit
@testable import Stella_McCartney

class MenuViewControllerMock: UIViewController {

    var listType: ProductsListType = .readyToWear
}

extension MenuViewControllerMock: MenuViewProtocol {
    
    func goToProductList(of type: ProductsListType) {
        listType = type
    }
}
