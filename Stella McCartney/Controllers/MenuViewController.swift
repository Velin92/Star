//
//  MenuViewController.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 18/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

protocol MenuViewProtocol where Self: UIViewController {
    func goToProductList()
}

class MenuViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var beautyView: UIView!
    @IBOutlet weak var lingerieView: UIView!
    @IBOutlet weak var readyToWearView: UIView!
    @IBOutlet weak var accessoriesView: UIView!
    
    var goToProductListClosure: (()->Void)?
    var viewModel: MenuViewModelProtocol!
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        let beautyViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnBeautyView(_:)))
         let readyToWearViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnReadyToWearView(_:)))
         let accessoriesViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnAccessoriesView(_:)))
         let lingerieViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnLingerieView(_:)))
        
        beautyView.addGestureRecognizer(beautyViewGestureRecognizer)
        lingerieView.addGestureRecognizer(lingerieViewGestureRecognizer)
        readyToWearView.addGestureRecognizer(readyToWearViewGestureRecognizer)
        accessoriesView.addGestureRecognizer(accessoriesViewGestureRecognizer)
    }
    
    @objc private func didTapOnBeautyView(_ sender: UITapGestureRecognizer) {
        viewModel.tappedOnBeauty()
    }
    
    @objc private func didTapOnReadyToWearView(_ sender: UITapGestureRecognizer) {
        viewModel.tappedOnReadyToWear()
    }
    
    @objc private func didTapOnLingerieView(_ sender: UITapGestureRecognizer) {
        viewModel.tappedOnLingerie()
    }
    
    @objc private func didTapOnAccessoriesView(_ sender: UITapGestureRecognizer) {
        viewModel.tappedOnAccessories()
    }
}

extension MenuViewController: MenuViewProtocol {
    
    func goToProductList() {
        goToProductListClosure?()
    }
}
