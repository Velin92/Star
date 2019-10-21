//
//  String+caseAndDiacriticInsensitiveContain.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 21/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation

extension String {
    
    func caseAndDiacriticInsensitiveContains(_ string: String) -> Bool {
        return range(of: string, options: [.literal, .caseInsensitive, .diacriticInsensitive]) != nil
    }
    
    func caseAndDiacriticInsensitiveContains(_ strings: [String]) -> Bool {
        guard strings.count > 0 else {
            return false
        }
        var allContained = true
        for string in strings {
            allContained = allContained && contains(string)
        }
        return allContained
    }
}
