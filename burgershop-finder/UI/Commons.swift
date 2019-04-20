//
//  Commons.swift
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

class SetupAnnotationView: MKAnnotationView, SetupProtocol {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
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

class SetupCollectionView: UICollectionView, SetupProtocol {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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

class SetupCollectionViewFlowLayout: UICollectionViewFlowLayout, SetupProtocol {
    override init() {
        super.init()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFromNib()
    }

    func setup() {}

    func setupFromNib() {}
}

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
