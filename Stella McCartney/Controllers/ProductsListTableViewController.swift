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
    var viewState: ProductsListViewState {get set}
    func goToProductDetail(for product: Product)
}

class ProductsListTableViewController: UITableViewController, Storyboarded {
    
    var viewModel: ProductsListViewModelProtocol!
    var goToProductDetailClosure: ((Product)->Void)?
    
    var viewState = ProductsListViewState(productSections: []){
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    private func updateView() {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadProductsList()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsSectionCell", for: indexPath) as? ProductsSectionTableViewCell else {
            fatalError("Cell not correctly setup in storyboard")
        }
        cell.viewState = viewState.productSections[indexPath.row]
        cell.selectedProductClosure = { [weak self] productIndex, cell in
            self?.selectedProduct(at: productIndex, in: cell)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState.productSections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    private func selectedProduct(at index: Int, in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            fatalError("Error something is wrong, this indexPath should exist")
        }
        viewModel.selectedProduct(at: index, in: indexPath.row)
    }
}

extension ProductsListTableViewController: ProductsListViewProtocol {
    
    func goToProductDetail(for product: Product) {
        goToProductDetailClosure?(product)
    }
}
