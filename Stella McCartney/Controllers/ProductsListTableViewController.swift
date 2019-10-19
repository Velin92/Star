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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsSectionCell", for: indexPath) as? ProductsSectionTableViewCell else {
            fatalError("Cell not correctly setup in storyboard")
        }
        cell.sectionLabel.text = "Section Test"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}

extension ProductsListTableViewController: ProductsListViewProtocol {
    
}
