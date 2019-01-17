//
//  FSDetails.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import MapKit

struct FSDetails: Codable {
    private var response: FSResponse

    var name: String {
        return response.venue.name
    }

    var coordinate: CLLocationCoordinate2D {
        let (latitude, longitude) = response.venue.location.asTuple()
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var image: UIImage? {
        guard let photo = response.venue.photo.group?.items.first else {
            return UIImage(named: "Cheeseburger")
        }

        return UIImage(photo)
    }

    // TODO: Revisit
    init(venueId id: String = String(),
         venueName name: String = String(),
         venueAddress address: String? = nil,
         venueLatitude latitude: Double = 0,
         venueLongitude longitude: Double = 0) {

        let location = FSLocation(address: address, latitude: latitude, longitude: longitude)
        let venue = FSVenue(id: id, name: name, location: location, photo: FSPhoto())
        self.response = FSResponse(venue: venue)
    }
}
