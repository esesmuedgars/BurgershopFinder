//
//  FSVenue.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

struct FSVenue: Codable {
    var id: String
    var name: String
    var location: FSLocation
    var photo: FSPhoto

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case photo = "photos"
    }
}
