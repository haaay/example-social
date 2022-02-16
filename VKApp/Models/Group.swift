//
//  Group.swift
//  VKApp
//
//  Created by hayk on 24/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import Foundation

class GroupResponse: Decodable {
    var container: GroupContainer
    lazy var items = container.items
    
    enum CodingKeys: String, CodingKey {
        case container = "response"
    }
}

struct GroupContainer: Decodable {
    var items: [Group]
}

class Group: Page, Decodable {
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.imageName = try container.decode(String.self, forKey: .imageName)
    }
}
