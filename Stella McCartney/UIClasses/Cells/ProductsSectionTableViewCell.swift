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
    
    var products = [ProductViewState]()
    
    func updateCell() {
        productsCollectionView.reloadData()
        productsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func resetCellScroll() {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        productsCollectionView.scrollToItem(at: firstIndexPath, at: .left, animated: false)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        products.removeAll()
        updateCell()
    }
}

extension ProductsSectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Collection View Cell not correctly set in the storyboard")
        }
        let cellViewState = products[indexPath.row]
        if #available(iOS 11.0, *) {
            cell.productImageView.backgroundColor = UIColor.skeletonBackground
        } else {
            cell.productImageView.backgroundColor = UIColor.lightSkeletonBackground
        }
        if let imageData = cellViewState.imageData {
            cell.productImageView.image = UIImage(data: imageData)
        } else {
            cell.productImageView.image = nil
        }
        cell.productNameLabel.text = cellViewState.name
        cell.productPriceLabel.text = "\(cellViewState.formattedPrice)"
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProductClosure?(indexPath.item, self)
    }
}
