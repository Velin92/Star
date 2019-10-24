//
//  Skeletonable.swift
//  Stella McCartney
//
//  Created by Mauro Romito on 24/10/2019.
//  Copyright © 2019 Mauro Romito. All rights reserved.
//

import Foundation
import UIKit

protocol Skeletonable where Self: UIViewController {
    func showSkeleton()
    func hideSkeleton()
}

extension Skeletonable {
    
    private var skeletonLayerName: String {
        return "skeletonLayerName"
    }
    
    private var skeletonGradientName: String {
        return "skeletonGradientName"
    }
    
    private var maskViewName: String {
        return "maskViewName"
    }
    
    private func skeletonViews(in view: UIView) -> [UIView] {
        var results = [UIView]()
        for subview in view.subviews as [UIView] {
            switch subview {
            case _ where subview.isKind(of: UILabel.self):
                results += [subview]
            case _ where subview.isKind(of: UIImageView.self):
                results += [subview]
            case _ where subview.isKind(of: UIButton.self):
                results += [subview]
            default: results += skeletonViews(in: subview)
            }
            
        }
        return results
    }
    
    func showSkeleton() {
        DispatchQueue.main.async {
            let skeletons = self.skeletonViews(in: self.view)
            var backgroundColor = UIColor.lightSkeletonBackground.cgColor
            var highlightColor = UIColor.lightSkeletonHighlight.cgColor
            if #available(iOS 11.0, *) {
                backgroundColor = UIColor.skeletonBackground.cgColor
                highlightColor =  UIColor.skeletonHighlight.cgColor
            }
            
            let skeletonLayer = CALayer()
            skeletonLayer.backgroundColor = backgroundColor
            skeletonLayer.name = self.skeletonLayerName
            skeletonLayer.anchorPoint = .zero
            skeletonLayer.frame.size = UIScreen.main.bounds.size
            
            skeletons.forEach {
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = UIScreen.main.bounds
                gradientLayer.name = self.skeletonGradientName
                
                $0.layer.mask = skeletonLayer
                $0.layer.addSublayer(skeletonLayer)
                $0.layer.addSublayer(gradientLayer)
                $0.clipsToBounds = true
                let width = UIScreen.main.bounds.width
                
                let animation = CABasicAnimation(keyPath: "transform.translation.x")
                animation.duration = 3
                animation.fromValue = -width
                animation.toValue = width
                animation.repeatCount = .infinity
                animation.autoreverses = false
                animation.fillMode = CAMediaTimingFillMode.forwards
                
                gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
            }
            let maskView = UIView(frame: self.view.frame)
            maskView.backgroundColor = .clear
            maskView.center = self.view.center
            maskView.tag = self.maskViewName.hashValue
            self.view.addSubview(maskView)
        }
    }
    
    func hideSkeleton() {
        DispatchQueue.main.async {
            self.skeletonViews(in: self.view).forEach {
                $0.layer.sublayers?.removeAll {
                    $0.name == self.skeletonLayerName || $0.name == self.skeletonGradientName
                }
            }
            let maskView = self.view.subviews.first( where: {
                $0.tag == self.maskViewName.hashValue
            })
            maskView?.removeFromSuperview()
        }
    }
}
