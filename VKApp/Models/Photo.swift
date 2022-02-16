//
//  Photo.swift
//  TairianVK
//
//  Created by hayk on 03/12/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoResponse: Decodable {
    var container: PhotoContainer
    lazy var items = container.items
    
    enum CodingKeys: String, CodingKey {
        case container = "response"
    }
}

struct PhotoContainer: Decodable {
    var items: [Photo]
}

class Photo: Object, Decodable {
    
    @objc dynamic var url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
    
    enum SizeKeys: String, CodingKey {
        case url
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var sizesContainer = try container.nestedUnkeyedContainer(forKey: .sizes)
        
        while !sizesContainer.isAtEnd {
            let sizeContainer = try sizesContainer.nestedContainer(keyedBy: SizeKeys.self)
            self.url = try sizeContainer.decode(String.self, forKey: .url)
        }
    }
}
