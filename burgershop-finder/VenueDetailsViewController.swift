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
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var addressLabel: TitleLabel!
    @IBOutlet private var priceLabel: TitleLabel!

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
        viewModel.titleLabelAttributedText
            .bind(to: titleLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)

        viewModel.imageViewImage
            .bind(to: imageView.rx.image)
            .disposed(by: viewModel.disposeBag)

        viewModel.addressLabelAttributedText
            .bind(to: addressLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)

        viewModel.priceLabelAttributedText
            .bind(to: priceLabel.rx.attributedText)
            .disposed(by: viewModel.disposeBag)
    }
}
