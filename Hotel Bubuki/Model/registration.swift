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
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}
