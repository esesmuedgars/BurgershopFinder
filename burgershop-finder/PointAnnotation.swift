//
//  PointAnnotation.swift
//  burgershop-finder
//
//  Created by e.vanags on 11/12/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import MapKit

final class PointAnnotation: MKPointAnnotation {

    var identifier: String = "unidentified"
    var phoneNumber: String?
    var address: String?
    var street: String?
    var postalCode: String?
    var countryCode: String?
    var county: String?
    var price: String?
    var likes: Int = 0
    var rating: Float?
    var image: UIImage?

    init(_ details: FSDetails?) {
        super.init()

        guard let details = details else { return }

        self.identifier = details.id
        self.title = details.name
        self.address = details.address
        self.street = details.street
        self.postalCode = details.postalCode
        self.countryCode = details.countryCode
        self.county = details.county
        self.coordinate = details.coordinate
        self.price = details.price
        self.likes = details.likes
        self.rating = details.rating
        self.image = details.image
    }
}
