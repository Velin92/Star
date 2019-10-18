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
        let interactor = MenuInteractor()
        let vm = MenuViewModel(view: vc, interactor: interactor)
        vc.viewModel = vm
        configureMenuViewController(vc)
        navigationController.pushViewController(vc, animated: false)
    }
    
    private func configureMenuViewController(_ viewController: MenuViewController) {
        viewController.goToProductListClosure = { [weak self] in
            self?.goToProductList()
        }
    }
    
    private func goToProductList() {
        let vc = ProductsListTableViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
}
