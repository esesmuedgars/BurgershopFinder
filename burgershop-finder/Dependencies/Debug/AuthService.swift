//
//  AuthService.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/01/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

final class AuthService: AuthServiceProtocol {

    var description: String {
        return "authorization service stub"
    }

    private var _authToken = BehaviorRelay<String?>(value: nil)
    var authToken: Observable<String?> {
        return _authToken.skip(1)
    }

    var rawToken: String? {
        return _authToken.value
    }

    func authorize(_ viewController: UIViewController) {
        _authToken.accept("TOKEN123")
    }

    func requestToken(_ url: URL) {}
}
