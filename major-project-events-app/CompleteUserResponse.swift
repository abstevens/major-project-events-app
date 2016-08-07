//
//  CompleteUserResponse.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 07/08/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import Foundation
import ObjectMapper

struct CompleteUserResponse: Mappable {
    
    var data: UserNode?
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        self.data <- map["data"]
    }
}

struct UserNode: Mappable {
    
    var id: Int?
    var username: String?
    var email: String?
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.username <- map["username"]
        self.email <- map["email"]
    }
}
