//
//  TurningNavigationController.swift
//  VKApp
//
//  Created by hayk on 27/09/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import UIKit

class PercentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var hasStarted = false
    var shouldFinish = false
}

class TurningNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = PercentDrivenInteractiveTransition()
    let turningAnimator = TurningAnimator(for: .none)
    var fromVC: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        view.backgroundColor = .white
        
        let edgeSwipeGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgeSwipe(_:)))
        edgeSwipeGR.edges = .left
        view.addGestureRecognizer(edgeSwipeGR)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.fromVC = fromVC
        
        switch operation {
        case .push:
            turningAnimator.operation = .push
            return turningAnimator
        case .pop:
            turningAnimator.operation = .pop
            return turningAnimator
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc func handleEdgeSwipe(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        
        guard turningAnimator.finished || interactiveTransition.hasStarted
            else { return }
        
        switch recognizer.state {
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
        case .changed:
            
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))
            
            interactiveTransition.shouldFinish = progress > 0.4
            interactiveTransition.update(progress)
            
        case .ended:
            
            interactiveTransition.hasStarted = false
            
            if interactiveTransition.shouldFinish {
                interactiveTransition.finish() }
            else {
                interactiveTransition.cancel()
                guard !self.viewControllers.contains(self.fromVC) else { return }
                self.pushViewController(self.fromVC, animated: false)
            }
            
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
        default:
            break
        }
        
    }

}
