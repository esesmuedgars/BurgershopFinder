//
//  VenueCell.swift
//  burgershop-finder
//
//  Created by e.vanags on 27/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit
import RxSwift

@IBDesignable
final class VenueCell: SetupCell {

    @IBInspectable
    public var borderWith: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWith
        }
    }

    @IBInspectable
    public var borderColor: UIColor? = nil {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBOutlet private var imageView: UIImageView!

    private var viewModel: VenueCellModel! {
        didSet {
            viewModel.inspectVenue()
        }
    }

    func configure(with viewModel: VenueCellModel) {
        self.viewModel = viewModel

        bindRx()
    }

    private func bindRx() {
        viewModel.venueImage
            .bind(to: imageView.rx.image)
            .disposed(by: viewModel.disposeBag)
    }
}
