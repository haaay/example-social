//
//  PhotoCell.swift
//  VKApp
//
//  Created by hayk on 24/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

let ExpandPhotoNotification = Notification.Name(rawValue: "ExpandPhotoNotification")

class PhotoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "photoCell"

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func expand(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: ExpandPhotoNotification, object: nil, userInfo: nil)
    }
}
