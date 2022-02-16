//
//  CancelControl.swift
//  VKApp
//
//  Created by hayk on 14/03/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import UIKit

let cancelColor = themeColor

class CancelControl: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    init(frame: CGRect, target: Any?, action: Selector) {
        super.init(frame: frame)
        setupView()
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setupView() {
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let width = rect.width
        let insetProportion: CGFloat = 0.3
        let inset = width * insetProportion
        let endCoordinate = width - inset
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: inset, y: inset))
        path.addLine(to: CGPoint(x: endCoordinate, y: endCoordinate))
        path.move(to: CGPoint(x: endCoordinate, y: inset))
        path.addLine(to: CGPoint(x: inset, y: endCoordinate))
        
        cancelColor.setStroke()
        path.lineWidth = 2.5
        path.lineCapStyle = .round
        
        path.stroke()
    }
    
}
