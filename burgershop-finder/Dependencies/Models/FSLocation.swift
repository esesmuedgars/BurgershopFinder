//
//  FSLocation.swift
//  burgershop-finder
//
//  Created by e.vanags on 10/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

struct FSLocation: Codable {
    var address: String?
    var street: String?
    var postalCode: String?
    var countryCode: String
    var county: String?
    var latitude: Double
    var longitude: Double

    private enum CodingKeys: String, CodingKey {
        case address
        case street = "crossStreet"
        case postalCode = "postalCode"
        case countryCode = "cc"
        case county = "state"
        case latitude = "lat"
        case longitude = "lng"
    }

    func asTuple() -> (latitude: Double, longitude: Double) {
        return (latitude, longitude)
    }
}
