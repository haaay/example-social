//
//  Cloud.swift
//  VKApp
//
//  Created by hayk on 06/09/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import UIKit

class Cloud: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 18 : 10
        let k: CGFloat = frame.width/18
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: k*3, y: k*7), radius: k*3, startAngle: .pi/2, endAngle: .pi*1.5, clockwise: true)
        path.addArc(withCenter: CGPoint(x: k*7, y: k*4), radius: k*4, startAngle: .pi, endAngle: .pi*1.75, clockwise: true)
        path.addArc(withCenter: CGPoint(x: k*12, y: k*3.4), radius: k*3, startAngle: .pi*1.25, endAngle: .pi*0.12, clockwise: true)
        path.addArc(withCenter: CGPoint(x: k*15.4, y: k*7.2), radius: k*2.8, startAngle: .pi*1.47, endAngle: .pi/2, clockwise: true)
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        shapeLayer.lineWidth = 1.3
        shapeLayer.fillColor = UIColor(white: 0.85, alpha: 0.7).cgColor
        shapeLayer.strokeColor = UIColor(white: 0.75, alpha: 0.7).cgColor
        shapeLayer.lineCap = .round
        
        layer.addSublayer(shapeLayer)
        
        let strokeStart = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        let strokeEnd = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        
        let lineLength: CGFloat = 0.15
        strokeStart.fromValue = 0
        strokeEnd.fromValue = lineLength
        strokeStart.toValue = 1 - lineLength
        strokeEnd.toValue = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.animations = [strokeEnd, strokeStart]
        animationGroup.repeatCount = .infinity
        
        shapeLayer.add(animationGroup, forKey: nil)
    }
    
}

