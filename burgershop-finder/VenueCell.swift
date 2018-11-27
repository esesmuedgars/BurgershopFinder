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
final class VenueCell: UICollectionViewCell {

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

    private var viewModel: VenueCellModel! {
        didSet {
            viewModel.inspectVenue()
        }
    }

    func configure(viewModel: VenueCellModel) {
        self.viewModel = viewModel

        addHandlers()
    }

    private func addHandlers() {
        viewModel.venueDetails.map { [weak self] (details) -> UIImage? in
            guard let identifier = self?.viewModel.venueId else { return UIImage(named: "Cheeseburger") }

            if let image = CacheManager.shared.cache.get(forKey: identifier) {
                return image
            } else {
                CacheManager.shared.cache.set(UIImage(named: "Cheeseburger"), forKey: identifier)
                guard let photos = details?.photos else { return UIImage(named: "Cheeseburger") }

                if let photo = photos.first {
                    let image = UIImage(photo)
                    CacheManager.shared.cache.set(image, forKey: identifier)
                    return image
                } else {
                    return UIImage(named: "Cheeseburger")
                }
            }
        }.observeOn(MainScheduler.asyncInstance)
        .bind(to: imageView.rx.image)
        .disposed(by: viewModel.disposeBag)
    }
}


