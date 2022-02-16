//
//  TurningAnimator.swift
//  VKApp
//
//  Created by hayk on 17/10/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import UIKit

class TurningAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var finished = true
    var operation: UINavigationController.Operation = .none
    private let animationDuration: TimeInterval = 0.85
    
    init(for operation: UINavigationController.Operation) {
        self.operation = operation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
            else { return }
        
        transitionContext.containerView.addSubview(source.view)
        transitionContext.containerView.addSubview(destination.view)
        
        let bounds = source.view.bounds
        let rightTransform = CGAffineTransform(rotationAngle: -.pi/2).concatenating(CGAffineTransform(translationX: (bounds.height+bounds.width)/2, y: -(bounds.height-bounds.width)/2))
        let leftTransform = CGAffineTransform(rotationAngle: .pi/2).concatenating(CGAffineTransform(translationX: -(bounds.height+bounds.width)/2, y: -(bounds.height-bounds.width)/2))
        
        switch self.operation {
        case .push:
            destination.view.transform = rightTransform
        case .pop:
            destination.view.transform = leftTransform
        default:
            break
        }
        
        UIView.animate(withDuration: animationDuration, animations: {
            
            self.finished = false
            
            switch self.operation {
            case .push:
                source.view.transform = leftTransform
                destination.view.transform = .identity
            case .pop:
                source.view.transform = rightTransform
                destination.view.transform = .identity
            default:
                break
            }
            
        }, completion: { finished in
            
            self.finished = true
            
            source.view.transform = .identity
            destination.view.transform = .identity
            transitionContext.completeTransition(finished)
        })
    }
    
}
