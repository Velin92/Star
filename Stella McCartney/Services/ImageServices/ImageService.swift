//
//  ImageService.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 21/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

enum ImageTypes: Comparable, CaseIterable {
    
    static func < (lhs: ImageTypes, rhs: ImageTypes) -> Bool {
        return allCases.firstIndex(of: lhs)! < allCases.firstIndex(of: rhs)!
    }
    
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

protocol ProductsListImageService {
    func loadImage(for code: String, imageType: ImageTypes, pixels: Int, completion: @escaping ((Data)-> Void))
}

protocol ProductDetailImageService {
    func loadAllImages(for code: String, pixels: Int, completion: @escaping (([ImageTypes : Data])-> Void) )
}

class ImageService {
    
    static let baseUrl = "https://www.stellamccartney.com/"
    
    let storage: CacheStorage? = CacheStorage(path: "images")
    
    private func generateJpegImageUrl(for code: String, imageTypeCode: String, resolutionCode: String) -> URL {
        let folderId = code.prefix(2)
        let urlPath = "\(ImageService.baseUrl)\(folderId)/\(code)_\(resolutionCode)_\(imageTypeCode).jpg"
        guard let url = URL(string: urlPath) else {
            fatalError("The url was not formatted properly")
        }
        return url
    }
    
    private func downloadJpegImages(from imageUrls: [ImageTypes : URL], completion: @escaping (([ImageTypes : Data])-> Void)) {
        let serviceGroup = DispatchGroup()
        var blocks: [DispatchWorkItem] = []
        var results: [ImageTypes : Data] = [:]
        for imageUrl in imageUrls {
            serviceGroup.enter()
            let block = DispatchWorkItem(flags: .inheritQoS) {
                if let data = try? Data(contentsOf: imageUrl.value), data.imageFormat == .jpg {
                    results[imageUrl.key] = data
                } else {
                    print("imageData for \(imageUrl.value) is nil")
                }
                serviceGroup.leave()
            }
            blocks.append(block)
            DispatchQueue.global().async(execute: block)
        }
        serviceGroup.notify(queue: DispatchQueue.main) {
            completion(results)
        }
    }
}

extension ImageService: ProductsListImageService {
    
    func loadImage(for code: String, imageType: ImageTypes, pixels: Int, completion: @escaping ((Data)-> Void)) {
        let resolutionCode = ImageResolutions.getBestResolution(for: pixels).code
        let typeCode = imageType.code
        let url = generateJpegImageUrl(for: code, imageTypeCode: typeCode, resolutionCode: resolutionCode)
        if let data = try? storage?.load(for: url.absoluteString) {
            completion(data)
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), data.imageFormat == .jpg {
                    try? self.storage?.save(value: data, for: url.absoluteString)
                    completion(data)
                } else {
                    print("imageData for \(code) is nil")
                }
            }
        }
    }
}

extension ImageService: ProductDetailImageService {
    
    func loadAllImages(for code: String, pixels: Int, completion: @escaping (([ImageTypes : Data])-> Void)) {
        let resolutionCode = ImageResolutions.getBestResolution(for: pixels).code
        let tuples = ImageTypes.allCases.map { (type: ImageTypes) -> (ImageTypes, URL) in
            let url =  generateJpegImageUrl(for: code, imageTypeCode: type.code, resolutionCode: resolutionCode)
            return (type, url)
        }
        let imageUrls = [ImageTypes:URL](uniqueKeysWithValues: tuples)
        downloadJpegImages(from: imageUrls, completion: completion)
    }
}
