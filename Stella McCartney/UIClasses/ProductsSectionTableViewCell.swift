//
//  ProductSectionTableViewCell.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 19/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

class ProductsSectionTableViewCell: UITableViewCell {
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var sectionLabel: UILabel!
    
    var viewState = ProductsSectionViewState(name: "", products: []){
        didSet {
            updateCell()
        }
    }
    
    private func updateCell() {
        sectionLabel.text = viewState.name
        productsCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
}

extension ProductsSectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewState.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Collection View Cell not correctly set in the storyboard")
        }
        let cellViewState =  viewState.products[indexPath.row]
        cell.productImageView.image = UIImage()
        cell.productNameLabel.text = cellViewState.name
        cell.productPriceLabel.text = "\(cellViewState.formattedPrice)"
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 182)
    }
    
    
}