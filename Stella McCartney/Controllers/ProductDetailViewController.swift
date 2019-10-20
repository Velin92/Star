//
//  ProductDetailViewController.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 20/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol where Self: UIViewController {
    
}

class ProductDetailViewController: UIViewController, Storyboarded {
    
    var product: Product!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        APIClient().productDetail(for: product.code8!) { result in
            switch result {
            case .failure:
                break
            case .success(let productDetailResponse):
                print(productDetailResponse)
                break
            }
        }
    }
    
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
