//
//  GradientView.swift
//  burgershop-finder
//
//  Created by e.vanags on 25/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

@IBDesignable
final class GradientView: SetupView {
    override func setup() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layer.frame = bounds
    }

    @IBInspectable
    public var topColor: UIColor = .white {
        didSet {
            guard let layer = self.layer as? CAGradientLayer else { return }
            layer.colors = [topColor.cgColor, bottomColor.cgColor]
        }
    }

    @IBInspectable
    public var bottomColor: UIColor = .white {
        didSet {
            guard let layer = self.layer as? CAGradientLayer else { return }
            layer.colors = [topColor.cgColor, bottomColor.cgColor]
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

