//
//  Session.swift
//  VKApp
//
//  Created by hayk on 26/11/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import Foundation

class Session {
    
    static let instance = Session()
    private init() { }
    
    var token: String?
    var userId: Int?
    
}
