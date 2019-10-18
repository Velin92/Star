//
//  Storyboarded.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 17/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded where Self: UIViewController {
        
    static func instantiate(from storyboardName: String) -> Self
    
}

extension Storyboarded {
    
    static func instantiate(from storyboardName: String = "Main") -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
    
}
