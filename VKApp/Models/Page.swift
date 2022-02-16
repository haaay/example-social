//
//  Page.swift
//  VKApp
//
//  Created by hayk on 24/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import Foundation
import RealmSwift

class Page: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var imageName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageName = "photo_100"
        // Page
        case name = "first_name"
        case surname = "last_name"
        // Group
        case title = "name"
    }
}
