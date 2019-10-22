//
//  Data+imageFormat.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 21/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

/*   SIGNATURE                 |           FORMAT                __________________________________________________________________
ÿØÿÛ                           |
ÿØÿà..JFIF..                   |           jpeg or jpg
ÿØÿá..Exif..                   |
__________________________________________________________________
.PNG....                       |           png
__________________________________________________________________
GIF87a                         |           gif
GIF89a                         |
__________________________________________________________________
RIFF....WEBP                   |           webp
*/

import Foundation

enum ImageFormat {
    case gif, jpg, png, webp, unknown
}

extension Data {
    var imageFormat: ImageFormat {
        if let string = String(data: self, encoding: .isoLatin1) {
            let prefix = String(string.prefix(30))
            if
                prefix.caseAndDiacriticInsensitiveContains("ÿØÿÛ") ||
                    prefix.caseAndDiacriticInsensitiveContains(["ÿØÿà", "JFIF"]) ||
                    prefix.caseAndDiacriticInsensitiveContains(["ÿØÿá", "Exif"])
            {
                return .jpg
            } else if prefix.contains("PNG") {
                return .png
            } else if
                prefix.caseAndDiacriticInsensitiveContains("GIF87a") ||
                    prefix.caseAndDiacriticInsensitiveContains("GIF89a")
            {
                return .gif
            } else if prefix.caseAndDiacriticInsensitiveContains(["RIFF", "WEBP"]) {
                return .webp
            } else {
                print ("prefix \(prefix) is unknown")
            }
        }
        return .unknown
    }
}
