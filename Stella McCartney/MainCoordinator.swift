//
//  MainCoordinator.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 17/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator {
    
    private weak var navigationController: UINavigationController!
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MenuViewController.instantiate()
        let vm = MenuViewModel(view: vc)
        vc.viewModel = vm
        configureMenuViewController(vc)
        navigationController.pushViewController(vc, animated: false)
    }
    
    private func configureMenuViewController(_ viewController: MenuViewController) {
        viewController.goToProductListClosure = { [weak self] productsListType in
            self?.goToProductsList(of: productsListType)
        }
    }
    
    private func goToProductsList(of type: ProductsListType) {
        let vc = ProductsListTableViewController.instantiate()
        let interactor = ProductsListInteractor(of: type, service: APIClient())
        let vm = ProductsListViewModel(view: vc, interactor: interactor)
        vc.viewModel = vm
        configureProductsListViewController(vc)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func configureProductsListViewController(_ viewController: ProductsListTableViewController) {
        viewController.goToProductDetailClosure = { [weak self] product in
            self?.goToProductDetail(of: product)
        }
    }
    
    private func goToProductDetail(of product: Product) {
        let vc = ProductDetailViewController.instantiate()
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
}
