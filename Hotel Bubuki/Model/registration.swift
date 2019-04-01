//
//  registration.swift
//  Hotel Bubuki
//
//  Created by Igor Shelginskiy on 11/20/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emaiAdress: String
    
    var checkInDate: Date
    var checkOutdate: Date
    var numberOfChildren: Int
    var numberOfAdult: Int
    
    var roomType: RoomType
    var wifi: Bool
}


struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var room = [
        RoomType(id: 0, name: "One bed room", shortName: "1B", price: 50),
        RoomType(id: 1, name: "Two beds room", shortName: "2B", price: 75),
        RoomType(id: 2, name: "Lux", shortName: "1L", price: 150)
    ]
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}
