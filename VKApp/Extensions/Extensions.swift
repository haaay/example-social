//
//  Extensions.swift
//  VKApp
//
//  Created by hayk on 03/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

extension Int {
    
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
    
    var toString: String {
        return String(self)
    }
}

extension Character {
    
    var toString: String {
        return "\(self)"
    }
}

extension String {
    
    func concatenating(_ string: String) -> String {
        return "\(self) \(string)"
    }
}

extension CGFloat {
    
    static var screenWidth = UIScreen.main.bounds.width
    static var screenHeight = UIScreen.main.bounds.height
    static var statusBarHeight = UIApplication.shared.statusBarFrame.height
}


extension UIImageView {
    
    func round() {
        setCornerRadius(frame.width/2)
    }
    
    func setCornerRadius(_ cornerRadius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    func transformTo(_ scale: CGFloat, withCornerRadius cornerRadius: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
        self.setCornerRadius(cornerRadius)
    }
    
    func fitIntoSuperviewByConstraints() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontal = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let vertical = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
        self.superview?.addConstraints([horizontal, vertical, width, height])
    }
        
}
