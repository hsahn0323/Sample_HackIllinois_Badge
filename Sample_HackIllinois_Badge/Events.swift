//
//  Events.swift
//  Sample_HackIllinois_Badge
//
//  Created by Hyosang Ahn on 9/20/19.
//  Copyright © 2019 Hyosang Ahn. All rights reserved.
//

import Foundation

struct EventResponse:Decodable {
    var response:Events
}

struct Events:Decodable {
    var events:[EventDetail]
}



struct EventDetail:Decodable {
    var name:String
    var location:EventLocation
}



struct EventLocation:Decodable {
    var latitude:Double
    var longitude:Double
}
