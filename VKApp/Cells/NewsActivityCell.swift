//
//  NewsActivityCell.swift
//  VKApp
//
//  Created by hayk on 17/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class NewsActivityCell: UITableViewCell {
    
    static let reuseIdentifier = "activity"

    @IBOutlet weak var likeControl: Like!
    @IBOutlet weak var commentControl: CommentControl!
    @IBOutlet weak var shareControl: ShareControl!
    @IBOutlet weak var viewsCounter: ViewsCounter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
