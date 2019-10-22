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
    
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    var viewModel: ProductDetailViewModelProtocol!
    var imagesCollectionDSD = ProductImagesCollectionDataSourceDelegate()
    var colorsCollectionDSD = ProductColorsCollectionDataSourceDelegate()
    var viewState = ProductDetailViewState(modelName: "", fullPrice: 0) {
        didSet {
            updateDataSources()
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    private func updateDataSources() {
        imagesCollectionDSD.imageDatas = viewState.imageDatas
        colorsCollectionDSD.cellViewStates = viewState.colors
    }
    
    private func updateView() {
        nameLabel.text = viewState.modelName
        let mutableAttributedString = NSMutableAttributedString(attributedString: priceLabel.attributedText!)
        mutableAttributedString.mutableString.setString(viewState.formattedFullPrice)
        if viewState.isDiscounted {
            mutableAttributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,mutableAttributedString.length))
            discountedPriceLabel.isHidden = false
            discountedPriceLabel.text = viewState.formattedDiscountedPrice
        } else {
            discountedPriceLabel.isHidden = true
        }
        priceLabel.attributedText = mutableAttributedString
        self.productImagesCollectionView.reloadData()
        self.colorsCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        viewModel.loadView()
    }
    
    private func setupCollectionViews() {
        setupProductImagesCollectionView()
        setupColorsCollectionView()
    }
    
    private func setupColorsCollectionView() {
        colorsCollectionView.delegate = colorsCollectionDSD
        colorsCollectionView.dataSource = colorsCollectionDSD
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
