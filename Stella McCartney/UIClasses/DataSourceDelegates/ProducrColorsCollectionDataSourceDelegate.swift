//
//  ProducrColorsCollectionDataSourceDelegate.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 22/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

class ProductColorsCollectionDataSourceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var cellViewStates = [ProductColorViewState]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewStates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductColorCell", for: indexPath) as? ProductColorCollectionViewCell else {
            fatalError("Cell not correctly setup in storyboard")
        }
        cell.colorNameLabel.text = cellViewStates[indexPath.row].colorName
        if let color = UIColor.hexStringToUIColor(hex: cellViewStates[indexPath.row].rgbColor) {
            cell.colorImageView.backgroundColor = color
        } else {
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
