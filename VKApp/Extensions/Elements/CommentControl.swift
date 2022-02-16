//
//  CommentControl.swift
//  VKApp
//
//  Created by hayk on 18/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class CommentControl: UIControl {
    
    var commentsCount: Int = 0
    
    let commentsCounter = UILabel()
    
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
        
        let height = rect.height
                
        let arcRadius: CGFloat = height * 0.16
        let startX: CGFloat = height * 0.08
        let startY: CGFloat = height * 0.12
        let horizontalLine: CGFloat = height * 0.52
        let verticalLine: CGFloat = height * 0.28
        
        let hookLeftInset: CGFloat = height * 0.04
        let hookRightInset: CGFloat = height * 0.16
        let hookHeight: CGFloat = height * 0.16
        
        let path = UIBezierPath()
        
        let topArcCenterY = startY + arcRadius
        let leftArcCenterX = startX + arcRadius
        
        path.addArc(withCenter: CGPoint(x: leftArcCenterX, y: topArcCenterY), radius: arcRadius, startAngle: -.pi, endAngle: -.pi/2, clockwise: true)
        
        let topLineEndX = leftArcCenterX + horizontalLine
        path.addLine(to: CGPoint(x: topLineEndX, y: startY))
        
        path.addArc(withCenter: CGPoint(x: topLineEndX, y: topArcCenterY), radius: arcRadius, startAngle: -.pi/2, endAngle: 0, clockwise: true)
        
        let bottomArcCenterY = topArcCenterY + verticalLine
        path.addLine(to: CGPoint(x: topLineEndX + arcRadius, y: bottomArcCenterY))
        
        path.addArc(withCenter: CGPoint(x: topLineEndX, y: bottomArcCenterY), radius: arcRadius, startAngle: 0, endAngle: .pi/2, clockwise: true)
        let bottomLineY = bottomArcCenterY + arcRadius
        path.addLine(to: CGPoint(x: topLineEndX-hookRightInset, y: bottomLineY))
        
        path.addLine(to: CGPoint(x: leftArcCenterX+hookLeftInset, y: bottomLineY+hookHeight))
        path.addLine(to: CGPoint(x: leftArcCenterX+hookLeftInset, y: bottomLineY))
        path.addLine(to: CGPoint(x: leftArcCenterX, y: bottomLineY))
        
        path.addArc(withCenter: CGPoint(x: leftArcCenterX, y: bottomArcCenterY), radius: arcRadius, startAngle: .pi/2, endAngle: .pi, clockwise: true)
        path.close()

        activityElementColor.setStroke()
        path.lineWidth = 2
        
        path.stroke()
        
        let inset = height + 5
        commentsCounter.frame = CGRect(x: inset, y: 0, width: rect.width - inset, height: height)
        commentsCounter.text = commentsCount.toString
        commentsCounter.textColor = activityElementColor
        commentsCounter.font = activityLabelFont
    }
    
    func setupView() {
        addSubview(commentsCounter)
    }

}
