//
//  DetailsVenue.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

struct DetailsVenue: Codable {
    var photo: Photo

    enum CodingKeys: String, CodingKey {
        case photo = "photos"
    }
}
