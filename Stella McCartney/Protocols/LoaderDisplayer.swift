//
//  LoaderDisplayer.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 24/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

protocol LoaderDisplayer where Self: UIViewController {
    func showLoader()
    func hideLoader()
}

extension LoaderDisplayer {
    func showLoader() {
        DispatchQueue.main.async {
            let maskView = UIView(frame: self.view.frame)
            if #available(iOS 13.0, *) {
                maskView.backgroundColor = .systemBackground
            } else {
                maskView.backgroundColor = .white
            }
            self.view.addSubview(maskView)
            var activityView: UIActivityIndicatorView
            if #available(iOS 13.0, *) {
                activityView = UIActivityIndicatorView(style: .large)
            } else {
                activityView = UIActivityIndicatorView(style: .gray)
            }
            activityView.center = self.view.center
            activityView.startAnimating()
            maskView.tag = String(describing: self).hashValue
            maskView.addSubview(activityView)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            if let maskView = self.view.subviews.first (where: {$0.tag == String(describing: self).hashValue}) {
                maskView.removeFromSuperview()
            }
        }
    }
}
