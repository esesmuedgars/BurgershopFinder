//
//  AuthServiceStub.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/01/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class AuthServiceStub: AuthServiceProtocol {

    var description: String {
        return "authorization service stub"
    }

    private var _authToken: Variable<String?> = Variable(nil)
    var authToken: Observable<String?> {
        return _authToken.asObservable().skip(1)
    }

    var rawToken: String? {
        return _authToken.value
    }

    func authorize(_ viewController: UIViewController) {
        _authToken.value = "TOKEN123"
    }

    func requestToken(_ url: URL) {}
}
