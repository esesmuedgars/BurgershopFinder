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

    private init(_ response: FSResponse) {
        self.response = response
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

    var coordinate: CLLocationCoordinate2D {
        let (latitude, longitude) = response.venue.location.asTuple()
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
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
