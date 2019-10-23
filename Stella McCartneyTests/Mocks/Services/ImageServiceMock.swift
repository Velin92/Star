//
//  ImageServiceMock.swift
//  Stella McCartneyTests
//
//  Created by Mauro Romito on 23/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
@testable import Stella_McCartney

class ImageServiceMock: ProductsListImageService {
    
    var data: Data!
    
    func loadImage(for code: String, imageType: ImageTypes, pixels: Int, completion: @escaping ((Data) -> Void)) {
        completion(data)
    }
}
