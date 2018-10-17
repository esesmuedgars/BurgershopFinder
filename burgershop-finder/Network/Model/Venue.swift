//
//  Venue.swift
//  burgershop-finder
//
//  Created by e.vanags on 10/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

typealias Venues = [Venue]

struct Venue: Codable {
    var id: String
    var name: String
    var location: Location
}
