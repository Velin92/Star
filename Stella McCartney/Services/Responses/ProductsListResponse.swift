//
//  ProductsListResponse.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 18/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

// MARK: - ProductsListResponse
struct ProductsListResponse: Codable {
    let header: Header?
    let resultsLite: ResultsLite?

    enum CodingKeys: String, CodingKey {
        case header = "Header"
        case resultsLite = "ResultsLite"
    }
}

// MARK: - Header
struct Header: Codable {
    let statusCode: Int?
    let headerDescription: String?

    enum CodingKeys: String, CodingKey {
        case statusCode = "StatusCode"
        case headerDescription = "Description"
    }
}

// MARK: - ResultsLite
struct ResultsLite: Codable {
    let totalResults: Int?
    let items: [Product]?

    enum CodingKeys: String, CodingKey {
        case totalResults = "TotalResults"
        case items = "Items"
    }
}

// MARK: - Item
struct Product: Codable {
    let code8: String
    let brandName: String?
    let defaultCode10, macroCategory: String?
    let microCategory: String
    let fullPrice: Int
    let discountedPrice: Int?
    let modelNames: String
    let sizes: [Size]?
    let colors: [Color]?

    enum CodingKeys: String, CodingKey {
        case code8 = "Code8"
        case brandName = "BrandName"
        case defaultCode10 = "DefaultCode10"
        case microCategory = "MicroCategory"
        case macroCategory = "MacroCategory"
        case fullPrice = "FullPrice"
        case discountedPrice = "DiscountedPrice"
        case modelNames = "ModelNames"
        case sizes = "Sizes"
        case colors = "Colors"
    }
}

// MARK: - Color
struct Color: Codable {
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
    }
}

// MARK: - Size
struct Size: Codable {
    let text: String?
    let classFamily: String?

    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case classFamily = "ClassFamily"
    }
}
