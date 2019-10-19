//
//  ProductsListTableViewController.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 18/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

protocol ProductsListViewProtocol where Self: UIViewController {
    
}

class ProductsListTableViewController: UITableViewController, Storyboarded {
    
    var viewModel: ProductsListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ProductsListTableViewController: ProductsListViewProtocol {
    
}
