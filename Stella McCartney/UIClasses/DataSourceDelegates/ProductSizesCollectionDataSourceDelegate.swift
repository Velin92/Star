//
//  ProductSizesCollectionDataSourceDelegate.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 22/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

class ProductSizesCollectionDataSourceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var cellViewState = [ProductSizeViewState]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewState.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSizeCell", for: indexPath) as? ProductSizeCollectionViewCell else {
            fatalError("Cell class not setup correctly in storyboard")
        }
        cell.sizeLabel.text = cellViewState[indexPath.item].formattedSize
        return cell
    }
}
