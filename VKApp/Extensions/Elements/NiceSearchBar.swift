//
//  NiceSearchBar.swift
//  VKApp
//
//  Created by hayk on 10/03/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import UIKit

protocol NiceSearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: NiceSearchBar)
    func searchBarTextDidEndEditing(_ searchBar: NiceSearchBar)
    func searchBarSearchButtonClicked(_ searchBar: NiceSearchBar)
    func searchBar(_ searchBar: NiceSearchBar, textDidChange searchText: String)
}

class NiceSearchBar: UIView, UITextFieldDelegate {
    
    // MARK: - Variables
    
    var delegate: NiceSearchBarDelegate?
    var isOriginalState = true
    var textField: UITextField!
    var placeView: UIView!
    let loupeLayer = CAShapeLayer()
    var cancel: CancelControl!
    
    var loupePlaceSide: CGFloat!
    let loupePlaceProportion: CGFloat = 0.6
    var loupeSide: CGFloat!
    let loupeProportion: CGFloat = 0.5
    let lenseProportion: CGFloat = 0.75
    let cancelProportion: CGFloat = 0.6
    var placeViewXInset: CGFloat!
    let placeViewXInsetProportion: CGFloat = 0.01
    let placeViewYInsetProportion: CGFloat = 0.1
    var cancelPlacePartWidth: CGFloat!
    let cancelPlacePartProportion: CGFloat = 0.1
    var cancelFrame: CGRect!
    var loupePosition: CGPoint!
    
    override var isFirstResponder: Bool {
        return textField.isFirstResponder
    }
    
    // MARK: - Life
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(in: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView(in: frame)
    }
    
    func setupView(in frame: CGRect) {
        
        let height = frame.height
        let width = frame.width
        
        loupePlaceSide = height * loupePlaceProportion
        placeViewXInset = width * placeViewXInsetProportion
        let placeViewYInset = height * placeViewYInsetProportion
        let textFieldLeftInset = placeViewXInset! + loupePlaceSide!
        cancelPlacePartWidth = width * cancelPlacePartProportion
        
        textField = UITextField(frame: frame)
        textField.frame.origin.x += textFieldLeftInset
        textField.frame.size.width -= textFieldLeftInset + cancelPlacePartWidth
        
        textField.returnKeyType = .search
        textField.tintColor = .lightGray
        textField.delegate = self
        
        placeView = UIView(frame: frame)
        placeView.frame.origin.x += placeViewXInset
        placeView.frame.size.width -= placeViewXInset * 2
        placeView.frame.origin.y += placeViewYInset
        placeView.frame.size.height -= placeViewYInset * 2
        placeView.backgroundColor = .groupTableViewBackground
        placeView.layer.cornerRadius = 15
        
        addSubview(placeView)
        addSubview(textField)
        
        let cancelSide = height * cancelProportion
        let cancelY = (height - cancelSide)/2
        cancelFrame = CGRect(origin: CGPoint(x: frame.width, y: cancelY), size: CGSize(width: cancelSide, height: cancelSide))
        
        cancel = CancelControl(frame: cancelFrame, target: self, action: #selector(cancelEvent))
        cancel.alpha = 0
        addSubview(cancel)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let height = rect.height

        loupeSide = loupePlaceSide * loupeProportion
        let lenseRadius = loupeSide * lenseProportion/2
        let loupeSideHalf = loupeSide/2
        let lenseCenterBias = loupeSideHalf - lenseRadius
        let center = CGPoint(x: loupeSide/2, y: height/2)
        let lenseCenter = CGPoint(x: center.x - lenseCenterBias, y: center.y - lenseCenterBias)
        let handleEndPoint = CGPoint(x: center.x + loupeSideHalf, y: center.y + loupeSideHalf)
        
        let loupePath = UIBezierPath(arcCenter: lenseCenter, radius: lenseRadius, startAngle: .pi/4, endAngle: .pi*2.25, clockwise: true)
        loupePath.addLine(to: handleEndPoint)
        
        loupeLayer.frame = CGRect(x: (rect.width-loupeSide)/2, y: 0, width: loupeSide, height: height)
        loupePosition = loupeLayer.position
        loupeLayer.path = loupePath.cgPath
        loupeLayer.fillColor = UIColor.clear.cgColor
        loupeLayer.strokeColor = UIColor.gray.cgColor
        loupeLayer.lineWidth = 2
        loupeLayer.lineCap = .round
        layer.addSublayer(loupeLayer)
    }
    
    @objc func cancelEvent() {
        
        if !textField.text!.isEmpty {
            textField.text = ""
            delegate?.searchBar(self, textDidChange: "")
        }
        
        func endEditing() { textField.endEditing(true) }
        textField.isFirstResponder ? endEditing() : originalStateAnimation()
    }
    
    // MARK: - Animations
    
    func searchStateAnimation() {
        
        isOriginalState = false
        
        loupeAnimation(fromOriginal: true)
        
        UIView.animate(withDuration: 0.7) {
            self.placeView.frame.size.width -= self.cancelPlacePartWidth
            self.cancel.frame.origin.x = self.placeView.frame.size.width + (self.cancelPlacePartWidth + self.placeViewXInset - self.cancel.frame.width)/2
            self.cancel.alpha = 1
        }
    }
    
    func originalStateAnimation() {
        
        isOriginalState = true
        
        loupeAnimation(fromOriginal: false)
        
        UIView.animate(withDuration: 0.7) {
            self.placeView.frame.size.width += self.cancelPlacePartWidth
            self.cancel.frame.origin.x = self.cancelFrame.origin.x
            self.cancel.alpha = 0
        }
    }
    
    func loupeAnimation(fromOriginal: Bool) {
        
        let originalX = loupeLayer.position.x
        let newX = placeViewXInset + loupePlaceSide/2 + 2.5
        
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = fromOriginal ? originalX : newX
        animation.toValue = fromOriginal ? newX : originalX
        animation.duration = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        animation.initialVelocity = 0.9
        animation.stiffness = 40
        animation.damping = 9.5
        
        loupeLayer.add(animation, forKey: nil)
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.searchBarTextDidBeginEditing(self)
        if isOriginalState { searchStateAnimation() }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchBarTextDidEndEditing(self)
        if textField.text!.isEmpty { originalStateAnimation() }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchBarSearchButtonClicked(self)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let newText = text.replacingCharacters(in: textRange, with: string)
            delegate?.searchBar(self, textDidChange: newText)
        }
        
        return true
    }
    
}
