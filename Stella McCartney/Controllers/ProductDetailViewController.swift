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
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    
    var viewModel: ProductDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupProductImagesCollectionView()
        viewModel.loadAdditionalDetails()
    }
    
    private func setupProductImagesCollectionView() {
        productImagesCollectionView.collectionViewLayout = ProductImagesFlowLayout()
        if #available(iOS 11.0, *) {
            productImagesCollectionView.contentInsetAdjustmentBehavior = .always
        }
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
    }
}

extension ProductDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCell", for: indexPath) as? ProductImageCollectionViewCell else {
            fatalError("Cell is not setup correctly in storyboard")
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
