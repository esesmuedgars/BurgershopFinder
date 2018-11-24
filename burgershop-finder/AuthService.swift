//
//  AuthService.swift
//  burgershop-finder
//
//  Created by e.vanags on 23/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol AuthServiceProtocol {

    /// Authorize user with Foursquare server.
    /// Will call `application(_:open:options:)` method of `UIApplicationDelegate` subclass on success.
    ///
    /// - Parameter viewController: `UIViewController` subclass which will present `FSOAuth` created WebView.
    func authorize(_ viewController: UIViewController)
    func requestToken(_ url: URL)

    var authToken: Observable<String?> { get }
}

final class AuthService: AuthServiceProtocol {

    private lazy var _authToken: Variable<String?> = Variable(nil)
    var authToken: Observable<String?> {
        return _authToken.asObservable()
    }

    private var authService: FSOAuth {
        return FSOAuth.shared()
    }

    func authorize(_ viewController: UIViewController) {
        let statuscode = authService.authorizeUser(usingClientId: Constants.identifier,
                                                   nativeURICallbackString: Constants.callbackURI,
                                                   universalURICallbackString: nil,
                                                   allowShowingAppStore: true,
                                                   presentFrom: viewController)

        var resultText: String = ""
        switch(statuscode) {
        case .success:
            break
        case .errorInvalidCallback:
            resultText = "Invalid callback URI"
        case .errorFoursquareNotInstalled:
            resultText = "Foursquare is not installed"
        case .errorInvalidClientID:
            resultText = "Invalid client id"
        case .errorFoursquareOAuthNotSupported:
            resultText = "Installed Foursquare App doesn't support oAuth"
        }
        print(resultText)
    }

    func requestToken(_ url: URL) {
        if (url.scheme == Constants.scheme) {
            var errorCode: FSOAuthErrorCode = .none
            let accessCode = authService.accessCode(forFSOAuthURL: url, error: &errorCode)

            if errorCode == .none {
                requestAccessToken(accessCode: accessCode!)
            } else {
                // FIXME: handle error
                print(errorMessageForCode(errorCode: errorCode))
            }
        }
    }

    private func requestAccessToken(accessCode: String) {
        authService.requestAccessToken(forCode: accessCode,
                                       clientId: Constants.identifier,
                                       callbackURIString: Constants.callbackURI,
                                       clientSecret: Constants.secret) { [weak self] (authToken, requestCompleted, errorCode) in
            if requestCompleted {
                if (errorCode == .none) {
                    // FIXME: use authToken!
                    print("request completed")
                    self?._authToken.value = authToken
                } else {
                    // FIXME: handle error
                    print(self?.errorMessageForCode(errorCode: errorCode) as Any)
                }
            } else {
                print("An error occured when attempting to connect to the Foursquare server.")
            }
        }
    }

    private func errorMessageForCode(errorCode: FSOAuthErrorCode) -> String {
        var resultText: String = ""
        switch errorCode {
        case .none:
            break
        case .invalidClient:
            resultText = "Invalid client error"
        case .invalidGrant:
            resultText = "Invalid grant error"
        case .invalidRequest:
            resultText = "Invalid request error"
        case .unauthorizedClient:
            resultText = "Invalid unauthorized client error"
        case .unsupportedGrantType:
            resultText = "Invalid unsupported grant error"
        case .unknown:
            resultText = "Unknown error"
        }
        return resultText
    }
}
