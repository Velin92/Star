//
//  UIColor+customColors.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 24/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var lightSkeletonBackground: UIColor {
        return UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    }
    
    static var lightSkeletonHighlight: UIColor {
        return UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
    }
    
    @available(iOS 11.0, *)
    static var skeletonBackground: UIColor {
        return UIColor(named: "skeletonBackground")!
    }
    
    @available(iOS 11.0, *)
    static var skeletonHighlight: UIColor {
        return UIColor(named: "skeletonHighlight")!
    }
}
