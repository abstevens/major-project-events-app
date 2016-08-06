//
//  EventResponse.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 19/07/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import Foundation
import ObjectMapper

struct CompleteEventResponse: Mappable {
    
    var data: [EventNode]?
    
    init?(_ map: Map) {}
    
    mutating func mapping(map: Map) {
        self.data <- map["data"]
    }
}

struct EventNode: Mappable {
    
    var id: Int?
    var organizerId: Int?
    var title: String?
    var eventDescription: String?
    var dateTime: String?
    var location: String?
    var price: Int?
    var limitReservations: Int?
    
    init?(_ map: Map) {}
    init?() {}
    
    mutating func mapping(map: Map) {
        self.organizerId <- map["organizer_id"]
        self.title <- map["title"]
        self.eventDescription <- map["description"]
        self.dateTime <- map["date_time"]
        self.location <- map["location"]
        self.price <- map["price"]
        self.limitReservations <- map["limit_reservations"]
    }
}
