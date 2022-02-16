//
//  PopupAnimator.swift
//  VKApp
//
//  Created by hayk on 16/10/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import UIKit

class PopupAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDuration: TimeInterval = 0.4
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
            else { return }
        
        let sourceFrame = source.view.frame
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = CGRect(x: 0, y: sourceFrame.height, width: sourceFrame.width, height: sourceFrame.height)
        
        UIView.animate(withDuration: animationDuration, animations: {
            destination.view.frame = sourceFrame
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
    
}

