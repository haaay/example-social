//
//  ShadowView.swift
//  VKApp
//
//  Created by hayk on 03/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    @IBInspectable var shadowRadius: CGFloat = 3.5
    @IBInspectable var shadowColor: UIColor = .lightGray
    @IBInspectable var shadowOpacity: Float = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setupView()
    }

    func setupView() {
        
        layer.cornerRadius = bounds.width/2
        
        addShadow()
    }

    func addShadow() {
        
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize.zero
    }
}

