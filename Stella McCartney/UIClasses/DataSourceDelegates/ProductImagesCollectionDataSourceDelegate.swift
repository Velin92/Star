//
//  ProductImagesCollectionDataSourceDelegate.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 21/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

class ProductImagesCollectionDataSourceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var imageStates = [ImageStates]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageStates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCell", for: indexPath) as? ProductImageCollectionViewCell else {
            fatalError("Cell is not setup correctly in storyboard")
        }
        if #available(iOS 11.0, *) {
            cell.productImageView.backgroundColor = UIColor.skeletonBackground
        } else {
            cell.productImageView.backgroundColor = UIColor.lightSkeletonBackground
        }
        if case let ImageStates.imageFound(imageData) = imageStates[indexPath.row] {
            cell.productImageView.image = UIImage(data: imageData)
            cell.productImageView.backgroundColor = .clear
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
