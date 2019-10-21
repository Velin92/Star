//
//  ImageService.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 21/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

enum ImageTypes {
    case front
    case rear
    case detailH
    case detailI
    case detailP
    case detailQ
    case detailS
    
    var code: String {
        switch self {
        case .front:
            return "c"
        case .rear:
            return "g"
        case .detailH:
            return "h"
        case .detailI:
            return "i"
        case .detailP:
            return "p"
        case .detailQ:
            return "q"
        case .detailS:
            return "s"
        }
    }
}

enum ImageResolutions: Int, CaseIterable {
    case low = 101
    case medium = 561
    case high = 1024
    case max = 2048
    
    static func getBestResolution(for pixelsNumber: Int) -> ImageResolutions {
        var min = Int.max
        var minCase = ImageResolutions.max
        for type in ImageResolutions.allCases {
            let absDifference = abs(pixelsNumber - type.rawValue)
            if absDifference <= min {
                min = absDifference
                minCase = type
            }
        }
        return minCase
    }
    
    var code: String {
        switch self {
        case .low:
            return "8"
        case .medium:
            return "11"
        case .high:
            return "12"
        case .max:
            return "13"
        }
    }
}

class ImageService {
    
    static let baseUrl = "https://www.stellamccartney.com/"
    
    func loadImage(for code: String, imageType: ImageTypes, pixels: Int, completion: @escaping ((Data)-> Void)) {
        let resolutionCode = ImageResolutions.getBestResolution(for: pixels).code
        let typeCode = imageType.code
        let url = generateImageUrl(for: code, imageTypeCode: typeCode, resolutionCode: resolutionCode)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                    completion(data)
            } else {
                print("imageData for \(code) is nil")
            }
        }
    }
    
    private func generateImageUrl(for code: String, imageTypeCode: String, resolutionCode: String) -> URL {
        let folderId = code.prefix(2)
        let urlPath = "\(ImageService.baseUrl)\(folderId)/\(code)_\(resolutionCode)_\(imageTypeCode).jpg"
        guard let url = URL(string: urlPath) else {
            fatalError("The url was not formatted properly")
        }
        return url
    }
    
}
