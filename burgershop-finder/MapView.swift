//
//  MapView.swift
//  burgershop-finder
//
//  Created by e.vanags on 25/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

@IBDesignable
final class MapView: SetupMapView {

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

