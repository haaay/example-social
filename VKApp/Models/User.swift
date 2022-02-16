//
//  User.swift
//  VKApp
//
//  Created by hayk on 24/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import Foundation

class UserResponse: Decodable {
    var container: UserContainer
    lazy var items = container.items
    
    enum CodingKeys: String, CodingKey {
        case container = "response"
    }
}

struct UserContainer: Decodable {
    var items: [User]
}

class User: Page, Decodable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        self.title = name.concatenating(surname)
    }
}
