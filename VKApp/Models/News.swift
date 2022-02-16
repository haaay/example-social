//
//  News.swift
//  VKApp
//
//  Created by hayk on 19/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import Foundation

class Public: Page {
    
    convenience init(title: String, imageName: String) {
        self.init()
        self.title = title
        self.imageName = imageName
    }
}

struct News {
    
    let source: Page
    let date: Date
    
    let text: String
    let photos: [String]
    
    let likesCount: Int
    let isLiked: Bool

    let commentsCount: Int
    let sharesCount: Int
    let viewsCount: Int
}
