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

    override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return .overCurrentContext
        }
        set {}
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindRx()
    }

    @IBAction func returnWasTapped() {
        dismiss(animated: true)
    }

    func configure(with viewModel: VenueDetailsViewModel) {
        self.viewModel = viewModel
    }

    private func bindRx() {
        viewModel.titleAttributedText
            .bind(to: titleLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)

        viewModel.addressAttributedText
            .bind(to: addressLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)

        viewModel.phoneNumberAttributedText
            .bind(to: phoneNumberLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)

        viewModel.noPhoneNumber
            .bind(to: phoneNumberStack.rx.isHidden)
            .disposed(by: viewModel.disposeBag)

        viewModel.priceAttributedText
            .bind(to: priceLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)

        viewModel.likesAttributedText
            .bind(to: likesLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)

        viewModel.ratingAttributedText
            .bind(to: ratingLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)

        viewModel.imageViewImage
            .bind(to: imageView.rx.image)
            .disposed(by: viewModel.disposeBag)
    }
}
