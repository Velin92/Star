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
    
    var selectedProductClosure: ((Int, UITableViewCell) -> Void)?
    var downloadProductImageClosure: (())
    
    var viewState = ProductsSectionViewState(name: "", products: []){
        didSet {
            DispatchQueue.main.async {
                self.updateCell()
            }
        }
    }
    
    private func updateCell() {
        sectionLabel.text = viewState.name
        productsCollectionView.reloadData()
        productsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewState.products.removeAll()
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
        if let imageData = cellViewState.imageData {
            cell.productImageView.image = UIImage(data: imageData)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProductClosure?(indexPath.item, self)
    }
}
