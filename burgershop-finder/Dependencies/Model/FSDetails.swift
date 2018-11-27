//
//  FSDetails.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

struct FSDetails: Codable {
    private var response: FSResponse

    var name: String {
        return response.venue.name
    }

    var location: FSLocation {
        return response.venue.location
    }

    var photos: FSItems? {
        return response.venue.photo.group?.items
    }
}
