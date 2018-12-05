//
//  Common.swift
//  burgershop-finder
//
//  Created by e.vanags on 28/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import MapKit
import UIKit

protocol SetupProtocol {
    func setup()
    func setupFromNib()
}

// MARK: SetupMapView
class SetupMapView: MKMapView, SetupProtocol {
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
        setupFromNib()
    }

    func setup() {}

    func setupFromNib() {}
}

// MARK: SetupView
class SetupView: UIView, SetupProtocol {
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
        setupFromNib()
    }

    func setup() {}

    func setupFromNib() {}
}

// MARK: SetupCell
class SetupCell: UICollectionViewCell, SetupProtocol {
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
        setupFromNib()
    }

    func setup() {}
    
    func setupFromNib() {}
}

// MARK: SetupLabel
class SetupLabel: UILabel, SetupProtocol {
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
        setupFromNib()
    }

    func setup() {}

    func setupFromNib() {}
}
