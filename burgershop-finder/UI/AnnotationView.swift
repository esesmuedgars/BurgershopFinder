//
//  AnnotationView.swift
//  burgershop-finder
//
//  Created by e.vanags on 10/12/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

final class AnnotationView: SetupAnnotationView {

    var button = UIButton(type: .detailDisclosure)

    convenience init(annotation: PointAnnotation) {
        self.init(annotation: annotation, reuseIdentifier: annotation.identifier)
    }

    override func setup() {
        canShowCallout = true

        let size = CGSize(width: 20, height: 30)
        image = UIImage(named: "Marker")?.withSize(size)
        rightCalloutAccessoryView = button

    }

    func setImage(_ image: UIImage?) {
        let size = CGSize(width: 20, height: 20)
        leftCalloutAccessoryView = UIImageView(image: image?.withSize(size))
    }
}
