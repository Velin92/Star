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
    private var interactor: MenuInteractorProtocol
    
    init(view: MenuViewProtocol, interactor: MenuInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func tappedOnReadyToWear() {
        //TO DO: call interactor
        view.goToProductList()
    }
    
    func tappedOnLingerie(){
        //TO DO: call interactor
        view.goToProductList()
    }
    
    func tappedOnAccessories() {
        //TO DO: call interactor
        view.goToProductList()
    }
    
    func tappedOnBeauty() {
        //TO DO: call interactor
        view.goToProductList()
    }
}
