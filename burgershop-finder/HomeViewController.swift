//
//  HomeViewController.swift
//  burgershop-finder
//
//  Created by e.vanags on 08/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private lazy var authorized = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !authorized {
            authorized = AuthManager.shared.authorize(presenter: self)
        }

        if let authToken = AuthManager.shared.authToken {
            APIService.shared.inspectVenue(with: authToken)
        }
    }
}



