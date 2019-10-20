//
//  Header.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 20/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

// MARK: - Header
struct Header: Codable {
    let statusCode: Int?
    let headerDescription: String?

    enum CodingKeys: String, CodingKey {
        case statusCode = "StatusCode"
        case headerDescription = "Description"
    }
}
