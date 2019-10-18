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
        navigationController.pushViewController(vc, animated: false)
    }
    
}
