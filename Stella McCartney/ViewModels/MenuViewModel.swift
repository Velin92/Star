//
//  MenuViewModel.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 18/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

protocol MenuViewModelProtocol {
    
    func tappedOnReadyToWear()
    func tappedOnLingerie()
    func tappedOnAccessories()
    func tappedOnBeauty()
}

class MenuViewModel: MenuViewModelProtocol {
    
    private weak var view: MenuViewProtocol!
    
    init(view: MenuViewProtocol) {
        self.view = view
    }
    
    func tappedOnReadyToWear() {
        //TO DO: call interactor
        view.goToProductList(of: .readyToWear)
    }
    
    func tappedOnLingerie(){
        //TO DO: call interactor
        view.goToProductList(of: .lingerie)
    }
    
    func tappedOnAccessories() {
        //TO DO: call interactor
        view.goToProductList(of: .accessories)
    }
    
    func tappedOnBeauty() {
        //TO DO: call interactor
        view.goToProductList(of: .beauty)
    }
}
