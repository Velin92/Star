//
//  ProductDetailViewState.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 21/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

enum ImageStates {
    case imageFound(imageData: Data)
    case imageLoading
    case imagesNotFound
}

enum AdditionalInfoState {
    case loading
    case notFound
    case found
}

struct ProductDetailViewState {
    
    var imageStates = [ImageStates]()
    let modelName: String
    private let fullPrice: Int
    private let discountedPrice: Int
    private let microCategory: String
    private let macroCategory: String
    let isDiscounted: Bool
    var colors = [ProductColorViewState]()
    var sizes = [ProductSizeViewState]()
    var additionalInfoState = AdditionalInfoState.loading
    
    init(modelName: String, macroCategory: String, microCategory: String, fullPrice: Int, discountedPrice: Int? = nil) {
        self.modelName = modelName
        self.fullPrice = fullPrice
        self.microCategory = microCategory
        self.macroCategory = macroCategory
        if let discountedPrice = discountedPrice {
            self.isDiscounted = discountedPrice < fullPrice
            self.discountedPrice = discountedPrice
        } else {
            self.isDiscounted = false
            self.discountedPrice = 0
        }
    }
    
    var formattedFullPrice: String {
        return "\(fullPrice)€"
    }
    
    var formattedDiscountedPrice: String {
        return "\(discountedPrice)€"
    }
    
    var formattedCategories: String {
        return "\(macroCategory) - \(microCategory)"
    }
    
    var colorText: String {
        if additionalInfoState == .notFound {
            return """
            Informazioni aggiuntive non disponibili.
            Verificare la connessione e riprovare più tardi
            """
        } else if colors.isEmpty  {
            return "Non ci sono colori disponibili"
        } else {
            return "Colori disponibili:"
        }
    }
    
    var sizesText: String {
        if sizes.isEmpty {
            return "Non ci sono taglie disponibili"
        } else {
            return "Taglie disponibili:"
        }
    }
}
