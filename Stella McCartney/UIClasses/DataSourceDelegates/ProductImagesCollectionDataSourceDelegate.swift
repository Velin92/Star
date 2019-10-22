//
//  ProductImagesCollectionDataSourceDelegate.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 21/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

class ProductImagesCollectionDataSourceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var imageDatas = [Data]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCell", for: indexPath) as? ProductImageCollectionViewCell else {
            fatalError("Cell is not setup correctly in storyboard")
        }
        cell.productImageView.image = UIImage(data: imageDatas[indexPath.item])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
