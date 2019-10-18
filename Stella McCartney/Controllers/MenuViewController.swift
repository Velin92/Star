//
//  MenuViewController.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 18/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewProtocol where Self: UIViewController {
    
}

class MenuViewController: UIViewController, Storyboarded {
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension MenuViewController: MainViewProtocol {
    
}
