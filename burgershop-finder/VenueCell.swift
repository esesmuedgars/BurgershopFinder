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
        viewModel.venueDetails.map { (details) -> UIImage? in
            guard let details = details else {
                print("details are nil")
                return #imageLiteral(resourceName: "Cheeseburger.pdf")
            }

            guard let photos = details.photos else {
                print("no venue in groups: \(details.photos)")
                return #imageLiteral(resourceName: "Cheeseburger.pdf")
            }

            if let url = photos.first {
                return UIImage(item: url)
            } else if let url = photos.last {
                return UIImage(item: url)
            } else {
                print("Not first nor last: \(details.photos)")
                return #imageLiteral(resourceName: "Cheeseburger.pdf")
            }
        }.observeOn(MainScheduler.asyncInstance)
            .bind(to: imageView.rx.image)
        .disposed(by: viewModel.disposeBag)
    }
}

extension UIImage {
    convenience init?(item: FSItem) {
        guard let data = try? Data(contentsOf: item.url) else { return nil }

        self.init(data: data)
    }
}
