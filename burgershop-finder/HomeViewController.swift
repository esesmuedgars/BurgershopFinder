//
//  HomeViewController.swift
//  burgershop-finder
//
//  Created by e.vanags on 08/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    private lazy var viewModel = HomeViewModel()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.authorize(self)
    }
}



