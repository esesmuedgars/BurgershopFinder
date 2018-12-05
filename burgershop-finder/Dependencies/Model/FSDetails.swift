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

    var location: MKAnnotation {
        let (latitude, longitude) = response.venue.location.asTuple()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        return annotation
    }

    var photos: FSItems? {
        return response.venue.photo.group?.items
    }
}
