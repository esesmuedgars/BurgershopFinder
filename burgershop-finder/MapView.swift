//
//  MapView.swift
//  burgershop-finder
//
//  Created by e.vanags on 25/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import MapKit

class SetupMapView: MKMapView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {}
}

@IBDesignable
final class MapView: SetupMapView {

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

