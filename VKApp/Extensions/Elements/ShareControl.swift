//
//  ShareControl.swift
//  VKApp
//
//  Created by hayk on 18/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class ShareControl: UIControl {
    
    var sharesCount: Int = 0
    
    let sharesCounter = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let height = rect.height * 0.95
        let arrowTopY = height * 0.3
        let arrowPeakX = height * 1.4
        let top = height * 0.15
        
        let path = UIBezierPath()
        
        path.addArc(withCenter: CGPoint(x: height, y: height-top), radius: height/2, startAngle: -.pi, endAngle: -.pi/2, clockwise: true)
        path.addLine(to: CGPoint(x: height, y: arrowTopY-top))
        path.addLine(to: CGPoint(x: arrowPeakX, y: (height+arrowTopY)/2-top))
        path.addLine(to: CGPoint(x: height, y: height-top))
        path.addLine(to: CGPoint(x: height, y: height*3/4-top))
        path.addArc(withCenter: CGPoint(x: height*0.92, y: height*5/4-top), radius: height/2, startAngle: -.pi/2, endAngle: -.pi*0.83, clockwise: false)
        
        activityElementColor.setStroke()
        path.lineWidth = 2
        
        path.stroke()
        
        let inset = arrowPeakX + 5
        sharesCounter.frame = CGRect(x: inset, y: 0, width: rect.width - inset, height: height)
        sharesCounter.text = sharesCount.toString
        sharesCounter.textColor = activityElementColor
        sharesCounter.font = activityLabelFont
    }
    
    func setupView() {
        addSubview(sharesCounter)
    }
    
}
