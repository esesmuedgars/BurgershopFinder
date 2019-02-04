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

    @IBOutlet private weak var imageView: UIImageView!

    private var gestureRecognizer: UIGestureRecognizer!
    public let touchUpInside = PublishSubject<Void>()

    private var viewModel: VenueCellModel! {
        didSet {
            viewModel.inspectVenue()
        }
    }

    override func setup() {
        super.setup()

        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUpInsideEvent))
    }

    @objc
    private func touchUpInsideEvent() {
        touchUpInside.onNext(())
    }

    func configure(with viewModel: VenueCellModel) {
        self.viewModel = viewModel

        addHandlers()
    }

    private func addHandlers() {
        viewModel.venueImage
            .bind(to: imageView.rx.image)
            .disposed(by: viewModel.disposeBag)

        imageView.addGestureRecognizer(gestureRecognizer)
    }

    deinit {
        imageView.removeGestureRecognizer(gestureRecognizer)
    }
}
