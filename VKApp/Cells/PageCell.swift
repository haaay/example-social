//
//  PageCell.swift
//  VKApp
//
//  Created by hayk on 24/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class PageCell: UITableViewCell, UITableViewDelegate {
    
    static let reuseIdentifier = "pageCell"

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var pageImageView: RoundImageView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var newsTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        
        pageImageView.addGestureRecognizer(tapGesture)        
    }
    
    @objc func tap(_ sender: UIGestureRecognizer) {
        
        func springTransformAnimation(for view: UIView) {
            
            let duration: Double = 0.8
            let scale: CGFloat = 0.8
            
            UIView.animate(withDuration: duration/5, animations: {
                view.transform = CGAffineTransform(scaleX: scale, y: scale)
            }) { (_) in
                UIView.animate(withDuration: duration*4/5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                    view.transform = .identity
                }, completion: nil)
            }
        }
        
        springTransformAnimation(for: avatarView)
    }

}

extension PageCell {
    func setImage(_ url: String) {
        apiConnection.getImage(url) { (image) in
            self.pageImageView.image = image
        }
    }
}
