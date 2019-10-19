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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
}

extension ProductsSectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Collection View Cell not correctly set in the storyboard")
        }
        cell.productImageView.image = UIImage()
        cell.productNameLabel.text = "Test Nome"
        cell.productPriceLabel.text = "50€"
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 182)
    }
    
    
}
