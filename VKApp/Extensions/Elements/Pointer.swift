//
//  Pointer.swift
//  VKApp
//
//  Created by hayk on 04/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

let tintColor = themeColor

@IBDesignable class Pointer: UIControl {
    
    var letters: [String] = [String]()
    
    var selectedLetter: String? = nil {
        didSet {
            updateSelectedLetter()
            sendActions(for: .valueChanged)
        }
    }
    
    private var points: [UIButton] = []
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        points.removeAll()
        
        for letter in letters {
            
            let point = UIButton(type: .system)
            point.setTitle(letter, for: .normal)
            point.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            point.tintColor = tintColor
            point.setTitleColor(.lightGray, for: .normal)
            point.setTitleColor(.white, for: .selected)
            point.addTarget(self, action: #selector(selectLetter(_:)), for: .touchUpInside)
            points.append(point)
        }
        
        stackView = UIStackView(arrangedSubviews: points)
        stackView.frame = bounds
        
        subviews.forEach { $0.removeFromSuperview() }
        addSubview(stackView)
        
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
    }
    
    @objc private func selectLetter(_ sender: UIButton) {
        
        guard let index = points.firstIndex(of: sender) else { return }
        
        selectedLetter = letters[index]
    }
    
    private func updateSelectedLetter() {
        for (index, point) in points.enumerated() {
            point.isSelected = selectedLetter == letters[index]
        }
    }
    
}
