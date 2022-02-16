//
//  NewsPhotoCell.swift
//  VKApp
//
//  Created by hayk on 18/08/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import UIKit

class NewsPhotoCell: UITableViewCell {
    
    //MARK: - Variables
    
    static let reuseIdentifier = "images"
    let maximizedScale: CGFloat = 1
    let maximizedCornerRadius: CGFloat = 0
    let minimizedScale: CGFloat = 0.5
    let minimizedCornerRadius = CGFloat.screenWidth/5
    
    var imageViews = [Int : UIImageView]()
    var interactiveAnimator: UIViewPropertyAnimator!
    var initialDirection: CGFloat = 1
    var index = 0
    var nextIndex = 0
    var firstView: UIImageView?
    var nextView: UIImageView?
    
    var photosNames: [String]? {
        didSet {
            
            imageViews.forEach { (view) in
                view.value.removeFromSuperview()
            }
            
            index = 0
            imageViews.removeAll()
            
            if var names = photosNames {
                
                while names.count > 2 {
                    names.removeLast()
                }
                
                for i in 0..<names.count {
                    addPhotoView(forIndex: i, withX: CGFloat.screenWidth * CGFloat(i))
                }
                
                for i in 0..<names.count {
                    imageViews[i]?.image = UIImage(named: names[i])
                }
                
                let hiddenView = self.imageViews[1]
                hiddenView?.transformTo(minimizedScale, withCornerRadius: minimizedCornerRadius)
            }
        }
    }
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        contentView.addGestureRecognizer(recognizer)
    }
    
    //MARK: - Photo Views' Methods
    
    @discardableResult func addPhotoView(forIndex index: Int, withX x: CGFloat) -> UIImageView {
        
        let photoFrame = CGRect(x: x, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenWidth)
        let view = UIImageView(frame: photoFrame)
        view.contentMode = .scaleToFill
        addSubview(view)
        imageViews[index] = view
        
        return view
    }
    
    func addNextView(ifItExists isNextViewExists: Bool, forIndex viewsIndex: Int, withX x: CGFloat, insteadOfExcessViewWithIndex excessViewIndex: Int) {
        
        guard let names = photosNames else {
            return
        }
        
        if isNextViewExists {
            
            let view = addPhotoView(forIndex: viewsIndex, withX: x)
            view.image = UIImage(named: names[viewsIndex])
            view.transformTo(minimizedScale, withCornerRadius: minimizedCornerRadius)
        }
        
        let removingView = imageViews.removeValue(forKey: excessViewIndex)
        removingView?.removeFromSuperview()
    }
    
    //MARK: - UIPanGestureRecognizer
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        
        guard let names = photosNames else { return }
        
        let viewSize = CGFloat.screenWidth
        let scrollFraction: CGFloat = 0.6
        
        func displace(minimized: UIImageView?, maximized: UIImageView?, forFraction fraction: CGFloat) {
            
            self.imageViews.forEach({ (view) in
                view.value.frame.origin.x += self.initialDirection * viewSize * fraction
            })
            
            minimized?.transformTo(self.minimizedScale, withCornerRadius: self.minimizedCornerRadius)
            maximized?.transformTo(self.maximizedScale, withCornerRadius: self.maximizedCornerRadius)
        }
        
        switch recognizer.state {
        case .began:
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut, animations: {
                
                self.initialDirection = CGFloat(recognizer.velocity(in: self.contentView).x > 0 ? 1 : -1)
                self.nextIndex = self.index - Int(self.initialDirection)
                
                guard self.nextIndex >= 0, names.count > self.nextIndex
                    else { return }
                
                self.firstView = self.imageViews[self.index]
                self.nextView = self.imageViews[self.nextIndex]
                
                displace(minimized: self.firstView, maximized: self.nextView, forFraction: 1)
            })
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: contentView)
            interactiveAnimator.fractionComplete = self.initialDirection * translation.x/viewSize/scrollFraction
        case .ended:
            
            let progress = interactiveAnimator.fractionComplete
            let shouldBeTheShift = progress > 0.5
            
            if !shouldBeTheShift {
                
                interactiveAnimator.addCompletion { (_) in
                    
                    let reverseAnimator = UIViewPropertyAnimator(duration: TimeInterval(0.5 * progress), curve: .easeInOut, animations: {
                        displace(minimized: self.nextView, maximized: self.firstView, forFraction: -progress)
                    })
                    
                    reverseAnimator.startAnimation()
                }
                
                interactiveAnimator.stopAnimation(false)
                interactiveAnimator.finishAnimation(at: .current)
            } else {
                
                index = nextIndex
                
                interactiveAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                
                let wasLeftSwipe = initialDirection < 0
                
                if wasLeftSwipe {
                    let rightViewIndex = index + 1
                    addNextView(ifItExists: names.count > rightViewIndex, forIndex: rightViewIndex, withX: viewSize, insteadOfExcessViewWithIndex:  index - 2)
                } else {
                    let leftViewIndex = index - 1
                    addNextView(ifItExists: leftViewIndex >= 0, forIndex: leftViewIndex, withX: -viewSize, insteadOfExcessViewWithIndex: index + 2)
                }
            }
        default:
            return
        }
    }

}
