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
    var viewState: ProductDetailViewState {get set}
}

class ProductDetailViewController: UIViewController, Storyboarded {
    
    var viewModel: ProductDetailViewModelProtocol!
    var imagesCollectionDSD = ProductImagesCollectionDataSourceDelegate()
    var viewState = ProductDetailViewState() {
        didSet {
            imagesCollectionDSD.imageDatas = viewState.imageDatas
            DispatchQueue.main.async {
                self.productImagesCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProductImagesCollectionView()
        viewModel.loadView()
    }
    
    private func setupProductImagesCollectionView() {
        productImagesCollectionView.collectionViewLayout = ProductImagesFlowLayout()
        if #available(iOS 11.0, *) {
            productImagesCollectionView.contentInsetAdjustmentBehavior = .always
        }
        productImagesCollectionView.delegate = imagesCollectionDSD
        productImagesCollectionView.dataSource = imagesCollectionDSD
    }
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
