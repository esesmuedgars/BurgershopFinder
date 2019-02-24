//
//  FSDetails.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import MapKit

final class FSDetails: Codable {
    private var response: FSResponse

    private enum CodingKeys: CodingKey {
        case response
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.response = try container.decode(FSResponse.self, forKey: .response)
    }

    var id: String {
        return response.venue.id
    }

    var name: String {
        return response.venue.name
    }

    var phoneNumber: String? {
        return response.venue.contact.phoneNumber
    }

    var address: String? {
        return response.venue.location.address
    }

    var street: String? {
        return response.venue.location.street
    }

    var postalCode: String? {
        return response.venue.location.postalCode
    }

    var countryCode: String {
        return response.venue.location.countryCode
    }

    var county: String? {
        return response.venue.location.county
    }

    var coordinate: CLLocationCoordinate2D {
        let (latitude, longitude) = response.venue.location.asTuple()
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var priceTier: Int {
        return response.venue.price.tier
    }

    var likes: Int {
        return response.venue.likes.count
    }

    var rating: Float {
        return response.venue.rating ?? 0
    }

    private var _image: UIImage?
    var image: UIImage? {
        persistIfNeeded()
        return _image
    }

    /// Initializes image from `FSDetails` `URL` and stores it in memory.
    /// Image reference in variable `_image`.
    private func persistIfNeeded() {
        guard _image == nil else { return }

        if let photo = response.venue.photo.group?.items.first {
            _image = UIImage(photo)
        } else {
            _image = UIImage(named: "Cheeseburger")
        }
    }
}
