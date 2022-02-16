//
//  Throbber.swift
//  VKApp
//
//  Created by hayk on 23/02/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import UIKit

class Throbber: UIControl {
    
    let dotsCount = 3
    let color = themeColor
    let firstOpacity: Float = 0.3
    let lastOpacity: Float = 1
    let duration: Double = 0.65
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = firstOpacity
        animation.toValue = lastOpacity
        animation.duration = duration
        animation.autoreverses = true
        animation.repeatCount = .greatestFiniteMagnitude
        
        let halfHeight = rect.height/2
        var x = halfHeight
        var i = 0
        
        while i < dotsCount {
            
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: halfHeight), radius: halfHeight*0.75, startAngle: 0, endAngle: .pi*2, clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = color.cgColor
            shapeLayer.opacity = firstOpacity
            layer.addSublayer(shapeLayer)
            shapeLayer.add(animation, forKey: nil)
            
            i += 1
            x += rect.height
            animation.timeOffset += animation.duration / Double(dotsCount - 1)
        }
    }

}
