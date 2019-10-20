//
//  ProductDetailResponse.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 20/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

// MARK: - ProductDetailResponse
struct ProductDetailResponse: Codable {
    let header: Header?
    let item: ProductDetail?

    enum CodingKeys: String, CodingKey {
        case header = "Header"
        case item = "Item"
    }
}

// MARK: - Item
struct ProductDetail: Codable {
    let customDescription: Bool?
    let authorID, sizeTypeID: Int?
    let gender, seasonOfSale, lastDataRetrieval, salesLineID: String?
    let salesLine: String?
    let finalSale: Bool?
    let code8: String?
    let macroCategory, microCategory: CroCategory?
    let brand, macroBrand: Brand?
    let imageTypes: [String]?
    let descriptions: [Description]?
    let modelColors: [ModelColor]?
    let modelSizes: [ModelSize]?
    let modelColorSize: [ModelColorSize]?
    let price: Price?
    let modelShot, fabric, model, madeIn: String?
    let divisionID: Int?
    let isNewArrival, permanent: Bool?
    let defaultCode10: String?

    enum CodingKeys: String, CodingKey {
        case customDescription = "CustomDescription"
        case authorID = "AuthorId"
        case sizeTypeID = "SizeTypeId"
        case gender = "Gender"
        case seasonOfSale = "SeasonOfSale"
        case lastDataRetrieval = "LastDataRetrieval"
        case salesLineID = "SalesLineId"
        case salesLine = "SalesLine"
        case finalSale = "FinalSale"
        case code8 = "Code8"
        case macroCategory = "MacroCategory"
        case microCategory = "MicroCategory"
        case brand = "Brand"
        case macroBrand = "MacroBrand"
        case imageTypes = "ImageTypes"
        case descriptions = "Descriptions"
        case modelColors = "ModelColors"
        case modelSizes = "ModelSizes"
        case modelColorSize = "ModelColorSize"
        case price = "Price"
        case modelShot = "ModelShot"
        case fabric = "Fabric"
        case model = "Model"
        case madeIn = "MadeIn"
        case divisionID = "DivisionId"
        case isNewArrival = "IsNewArrival"
        case permanent = "Permanent"
        case defaultCode10 = "DefaultCode10"
    }
}

// MARK: - Brand
struct Brand: Codable {
    let id: Int?
    let name, katakanaName: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case katakanaName = "KatakanaName"
    }
}

// MARK: - Description
struct Description: Codable {
    let key, value, c10: String?

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case value = "Value"
        case c10 = "C10"
    }
}

// MARK: - CroCategory
struct CroCategory: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}

// MARK: - ModelColorSize
struct ModelColorSize: Codable {
    let idColor, idSize, quantity: Int?
    let isFastDelivery: Bool?

    enum CodingKeys: String, CodingKey {
        case idColor = "IdColor"
        case idSize = "IdSize"
        case quantity = "Quantity"
        case isFastDelivery = "IsFastDelivery"
    }
}

// MARK: - ModelColor
struct ModelColor: Codable {
    let code10: String?
    let colorID, macroColorID: Int?
    let colorDescription, rgb: String?

    enum CodingKeys: String, CodingKey {
        case code10 = "Code10"
        case colorID = "ColorId"
        case macroColorID = "MacroColorId"
        case colorDescription = "ColorDescription"
        case rgb = "Rgb"
    }
}

// MARK: - ModelSize
struct ModelSize: Codable {
    let sizeID, sortOrder: Int?
    let modelSizeDefault: Default?

    enum CodingKeys: String, CodingKey {
        case sizeID = "SizeId"
        case sortOrder = "SortOrder"
        case modelSizeDefault = "Default"
    }
}

// MARK: - Default
struct Default: Codable {
    let labeled: Bool?
    let size: Int?
    let text, classFamily: String?

    enum CodingKeys: String, CodingKey {
        case labeled = "Labeled"
        case size = "Size"
        case text = "Text"
        case classFamily = "ClassFamily"
    }
}

// MARK: - Price
struct Price: Codable {
    let discountedPrice, fullPrice: Int?

    enum CodingKeys: String, CodingKey {
        case discountedPrice = "DiscountedPrice"
        case fullPrice = "FullPrice"
    }
}
