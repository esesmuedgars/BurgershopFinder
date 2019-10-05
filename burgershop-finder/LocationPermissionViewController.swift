//
//  LocationPermissionViewController.swift
//  burgershop-finder
//
//  Created by e.vanags on 01/10/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import UIKit
import RxSwift

final class LocationPermissionViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var button: UIButton! {
        didSet {
            button.layer.cornerRadius = 5
        }
    }

    @IBAction func didTouchUpInside() {
        viewModel.requestAuthorizationOrOpenSettings()
    }

    private let viewModel = LocationPermissionViewModel()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindRx()
    }

    private func bindRx() {
        descriptionLabel.text = viewModel.descriptionText

        viewModel.buttonTitle
            .bind(to: button.rx.title(for: .normal))
            .disposed(by: viewModel.disposeBag)

        viewModel.authorized
            .subscribe(onNext: { [weak self] in
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
}
