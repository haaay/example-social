//
//  Like.swift
//  VKApp
//
//  Created by hayk on 03/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

public var activityElementColor = UIColor(red: 0.6, green: 0.64, blue: 0.68, alpha: 1.0)
public var activityLabelFont = UIFont(name: "HelveticaNeue-Medium", size: 16)

class Like: UIControl {
    
    var isLiked: Bool = false
    var likesCount: Int = 0
    
    let likes = UILabel()
    
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
        let arcRadius = sqrt(pow(height * 0.4, 2) + pow(height * 0.3, 2))/2
        
        let path = UIBezierPath()
        
        path.addArc(withCenter: CGPoint(x: height * 0.3, y: height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        
        path.addArc(withCenter: CGPoint(x: height * 0.7, y: height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        
        path.addLine(to: CGPoint(x: height * 0.5, y: height * 0.9))
        path.close()
        
        activityElementColor.setStroke()
        UIColor.red.setFill()
        
        path.lineWidth = 2
        
        isLiked ? path.fill() : path.stroke()
        
        let inset = height + 5
        likes.frame = CGRect(x: inset, y: 0, width: rect.width - inset, height: height)
        likes.text = likesCount.toString
        likes.textColor = isLiked ? .red : activityElementColor
        likes.font = activityLabelFont
    }
    
    func setupView() {
        addTarget(self, action: #selector(changeState), for: .touchUpInside)
        addSubview(likes)
    }
    
    @objc func changeState() {
        
        likesCount += !isLiked ? 1 : -1
        isLiked.toggle()
        
        UIView.transition(with: likes, duration: 0.3, options: .transitionFlipFromTop, animations: {
            self.setNeedsDisplay()
        }, completion: nil)
    }
}
