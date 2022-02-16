//
//  ViewsCounter.swift
//  VKApp
//
//  Created by hayk on 18/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class ViewsCounter: UIControl {
    
    var viewsCount: Int = 0
    let color = UIColor(red: 0.78, green: 0.8, blue: 0.82, alpha: 1.0)

    let viewsCounter = UILabel()
    
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
        
        let height = rect.height*1.2
        let arcRadius = height*0.45
        let centerX = height/2
        let topStartAngle: CGFloat = -.pi*0.8
        let topEndAngle = topStartAngle + (-.pi/2 - topStartAngle)*2

        let eyelidPath = UIBezierPath()
        
        eyelidPath.addArc(withCenter: CGPoint(x: centerX, y: height*3/4), radius: arcRadius, startAngle: topStartAngle, endAngle: topEndAngle, clockwise: true)
        eyelidPath.addArc(withCenter: CGPoint(x: centerX, y: height/4), radius: arcRadius, startAngle: -topEndAngle, endAngle: -topStartAngle, clockwise: true)
        eyelidPath.close()
        
        color.setFill()
        eyelidPath.fill()
        
        let eyeStartAngle: CGFloat = 0
        let eyeEndAngle: CGFloat = .pi*2
        let eyeballRadius = height*0.14
        
        let eyeballPath = UIBezierPath()
        eyeballPath.addArc(withCenter: CGPoint(x: centerX, y: centerX), radius: eyeballRadius, startAngle: eyeStartAngle, endAngle: eyeEndAngle, clockwise: true)
        
        UIColor.white.setFill()
        eyeballPath.fill()
        
        let eyePath = UIBezierPath()
        eyePath.addArc(withCenter: CGPoint(x: centerX, y: centerX), radius: eyeballRadius/2, startAngle: eyeStartAngle, endAngle: eyeEndAngle, clockwise: true)
        
        color.setFill()
        eyePath.fill()

        let inset = height + 5
        viewsCounter.frame = CGRect(x: inset, y: 0, width: rect.width - inset, height: height)
        viewsCounter.text = viewsCount.toString
        viewsCounter.textColor = color
        viewsCounter.font = activityLabelFont
    }
    
    func setupView() {
        
        addSubview(viewsCounter)
        viewsCount += 1
    }
    
}
