//
//  Venue.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

struct Venue: Codable {
    var id: String
    var name: String
    var location: Location
    var photo: Photo

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case photo = "photos"
    }
}
