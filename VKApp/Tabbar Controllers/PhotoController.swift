//
//  PhotoController.swift
//  VKApp
//
//  Created by hayk on 20/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class PhotoController: UICollectionViewController, UIViewControllerTransitioningDelegate {
    
    // MARK: Variables
    
    var images = [UIImage]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.expandPhoto(notification:)), name: ExpandPhotoNotification, object: nil)
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell
            else {
                return UICollectionViewCell()
        }
        
        cell.photoImageView.image = images[indexPath.row]
        
        return cell
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopupAnimator()
    }
    
    // MARK: Photo Presenting
    
    @objc func expandPhoto(notification: Notification) {
        
        let expandedPhotoVC = UIViewController()
        expandedPhotoVC.transitioningDelegate = self
        
        guard let image = self.images.first else { return }
        
        let photo = UIImageView(image: image)
        photo.contentMode = .scaleAspectFit
        expandedPhotoVC.view.backgroundColor = .black
        expandedPhotoVC.view.addSubview(photo)
        photo.fitIntoSuperviewByConstraints()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedView))
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissPresentedView))
        swipeGestureRecognizer.direction = .down
        
        expandedPhotoVC.view.addGestureRecognizer(tapGestureRecognizer)
        expandedPhotoVC.view.addGestureRecognizer(swipeGestureRecognizer)
        
        present(expandedPhotoVC, animated: true, completion: nil)
    }
    
    @objc func dismissPresentedView() {
        dismiss(animated: true, completion: nil)
    }

}
