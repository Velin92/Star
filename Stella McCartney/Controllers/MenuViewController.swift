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
    func goToProductList(of type: ProductsListType)
}

class MenuViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var beautyView: UIView!
    @IBOutlet weak var lingerieView: UIView!
    @IBOutlet weak var readyToWearView: UIView!
    @IBOutlet weak var accessoriesView: UIView!
    @IBOutlet weak var beautyLabel: UILabel!
    @IBOutlet weak var lingerieLabel: UILabel!
    @IBOutlet weak var readyToWearLabel: UILabel!
    @IBOutlet weak var accessoriesLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var goToProductListClosure: ((ProductsListType)->Void)?
    var viewModel: MenuViewModelProtocol!
    
    override func viewDidLoad() {
        setupBlurView()
        setupLabels()
        setupGestureRecognizers()
    }
    
    private func setupBlurView(){
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        if #available(iOS 11.0, *) {
            blurView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
           blurView.bottomAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    private func setupLabels() {
        if #available(iOS 11.0, *) {
            accessoriesLabel.backgroundColor = UIColor.menuLabelsColor
            readyToWearLabel.backgroundColor = UIColor.menuLabelsColor
            lingerieLabel.backgroundColor = UIColor.menuLabelsColor
            beautyLabel.backgroundColor = UIColor.menuLabelsColor
        }
        accessoriesLabel.layer.masksToBounds = true
        accessoriesLabel.layer.cornerRadius = accessoriesLabel.frame.height/5
        readyToWearLabel.layer.masksToBounds = true
        readyToWearLabel.layer.cornerRadius = readyToWearLabel.frame.height/5
        beautyLabel.layer.masksToBounds = true
        beautyLabel.layer.cornerRadius = accessoriesLabel.frame.height/5
        lingerieLabel.layer.masksToBounds = true
        lingerieLabel.layer.cornerRadius = lingerieLabel.frame.height/5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    func goToProductList(of type: ProductsListType) {
        goToProductListClosure?(type)
    }
}
