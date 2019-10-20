//
//  ProductDetailViewController.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 20/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol where Self: UIViewController {
    
}

class ProductDetailViewController: UIViewController, Storyboarded {
    
    var viewModel: ProductDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadAdditionalDetails()
    }
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
