//
//  NewsTextCell.swift
//  VKApp
//
//  Created by hayk on 18/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class NewsTextCell: UITableViewCell {

    static let reuseIdentifier = "text"

    @IBOutlet weak var textLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
