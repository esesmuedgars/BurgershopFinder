//
//  FSLocation.swift
//  burgershop-finder
//
//  Created by e.vanags on 10/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

final class FSLocation: NSObject, Codable {
    var address: String?
    var latitude: Double
    var longitude: Double

    enum CodingKeys: String, CodingKey {
        case address
        case latitude = "lat"
        case longitude = "lng"
    }

    init(address: String?, latitude: Double, longitude: Double) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.address = try? container.decode(String.self, forKey: .address)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
