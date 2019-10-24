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
    
    @IBOutlet weak var sizesLabel: UILabel!
    @IBOutlet weak var colorsLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var sizesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var viewModel: ProductDetailViewModelProtocol!
    private let imagesCollectionDSD = ProductImagesCollectionDataSourceDelegate()
    private let colorsCollectionDSD = ProductColorsCollectionDataSourceDelegate()
    private let sizesCollectionDSD = ProductSizesCollectionDataSourceDelegate()
    
    var viewState = ProductDetailViewState(modelName: "", macroCategory: "", microCategory: "", fullPrice: 0) {
        didSet {
            updateDataSources()
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    private func updateDataSources() {
        imagesCollectionDSD.imageStates = viewState.imageStates
        colorsCollectionDSD.cellViewStates = viewState.colors
        sizesCollectionDSD.cellViewState = viewState.sizes
    }
    
    private func updateView() {
        nameLabel.text = viewState.modelName
        categoriesLabel.text = viewState.formattedCategories
        updatePriceLabels()
        reloadCollectionViews()
        updateAdditionalInfoViews()
    }
    
    private func updateAdditionalInfoViews() {
        switch viewState.additionalInfoState {
        case .notReady:
            hideAdditionalInfoViews()
        case .missing:
            setAdditionInfoViewsMissing()
        case .ready:
            setAdditionalInfoViewsReady()
        }
        colorsLabel.text = viewState.colorText
        sizesLabel.text = viewState.sizesText
    }
    
    private func setAdditionalInfoViewsReady() {
        colorsLabel.isHidden = false
        sizesLabel.isHidden = false
        colorsCollectionView.isHidden = viewState.colors.isEmpty
        sizesCollectionView.isHidden = viewState.sizes.isEmpty
    }
    
    private func setAdditionInfoViewsMissing() {
        colorsCollectionView.isHidden = true
        sizesCollectionView.isHidden = true
        sizesLabel.isHidden = true
        colorsLabel.isHidden = false
    }
    
    private func hideAdditionalInfoViews() {
        colorsCollectionView.isHidden = true
        sizesCollectionView.isHidden = true
        colorsLabel.isHidden = true
        sizesLabel.isHidden = true
    }
    
    private func updatePriceLabels() {
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
    }
    
    private func reloadCollectionViews() {
        self.productImagesCollectionView.reloadData()
        self.colorsCollectionView.reloadData()
        self.sizesCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        viewModel.loadView()
    }
    
    private func setupCollectionViews() {
        setupProductImagesCollectionView()
        setupColorsCollectionView()
        setupSizesCollectionView()
    }
    
    private func setupColorsCollectionView() {
        colorsCollectionView.delegate = colorsCollectionDSD
        colorsCollectionView.dataSource = colorsCollectionDSD
    }
    
    private func setupSizesCollectionView() {
        sizesCollectionView.delegate = sizesCollectionDSD
        sizesCollectionView.dataSource = sizesCollectionDSD
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
