//
//  PointAnnotation.swift
//  burgershop-finder
//
//  Created by e.vanags on 11/12/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import MapKit

final class PointAnnotation: MKPointAnnotation {

    public var image: UIImage?

    init(_ details: FSDetails?) {
        super.init()

        guard let details = details else { return }

        self.image = details.image
        self.coordinate = details.coordinate
        self.title = details.name
    }
}
