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
        viewModel.requestAuthorization()
    }

    private let viewModel = LocationPermissionViewModel()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return .fullScreen
        }
        set {
            print("modalPresentationStyle of LocationPermissionViewController is overriden to always return UIModalPresentationStyle.fullScreen")
        }
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

        viewModel.fetchValues()
    }
}
