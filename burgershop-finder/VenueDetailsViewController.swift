//
//  VenueDetailsViewController.swift
//  burgershop-finder
//
//  Created by e.vanags on 13/02/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class VenueDetailsViewController: UIViewController {

    @IBOutlet private var titleLabel: TitleLabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var phoneNumberLabel: UILabel!
    @IBOutlet private var phoneNumberStack: UIStackView!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var likesLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 10
        }
    }

    private var viewModel: VenueDetailsViewModel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindRx()
    }

    func configure(with viewModel: VenueDetailsViewModel) {
        self.viewModel = viewModel
    }

    private func bindRx() {
        titleLabel.text = viewModel.titleText
        addressLabel.text = viewModel.addressText
        phoneNumberLabel.text = viewModel.phoneNumberText
        phoneNumberStack.isHidden = viewModel.noPhoneNumber
        priceLabel.attributedText = viewModel.priceAttributedText
        likesLabel.text = viewModel.likesText
        ratingLabel.text = viewModel.ratingText
        imageView.image = viewModel.image
    }
}
