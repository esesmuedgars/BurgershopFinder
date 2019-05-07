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

final class AuthService: AuthServiceProtocol {

    var description: String {
        return "authorization service"
    }

    private lazy var _authToken: Variable<String?> = Variable(nil)
    var authToken: Observable<String?> {
        return _authToken.asObservable().skip(1).flatMap { authToken -> Observable<String?> in
            return Observable<String?>.create { observer -> Disposable in
                if let authToken = authToken {
                    observer.onNext(authToken)
                    observer.onCompleted()
                } else {
                    observer.onError("Failed to retrieve token.")
                }

                return Disposables.create()
            }
        }
    }

    var rawToken: String? {
        return _authToken.value
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

        switch(statuscode) {
        case .success:
            return
        case .errorInvalidCallback:
            print("Invalid callback URI")
        case .errorFoursquareNotInstalled:
            print("Foursquare is not installed")
        case .errorInvalidClientID:
            print("Invalid client identifier")
        case .errorFoursquareOAuthNotSupported:
            print("Installed Foursquare App doesn't support oAuth")
        @unknown default:
            break
        }

        _authToken.value = nil
    }

    func requestToken(_ url: URL) {
        if (url.scheme == Constants.scheme) {
            var errorCode: FSOAuthErrorCode = .none
            let accessCode = authService.accessCode(forFSOAuthURL: url, error: &errorCode)

            if errorCode == .none {
                requestAccessToken(accessCode: accessCode!)
            } else {
                errorMessageForCode(errorCode: errorCode)
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
                    self?._authToken.value = authToken
                } else {
                    self?.errorMessageForCode(errorCode: errorCode)
                }
            } else {
                print("An error occured when attempting to connect to the Foursquare server.")
            }
        }
    }

    private func errorMessageForCode(errorCode: FSOAuthErrorCode) {
        switch errorCode {
        case .none:
            return
        case .invalidClient:
            print("Invalid client error")
        case .invalidGrant:
            print("Invalid grant error")
        case .invalidRequest:
            print("Invalid request error")
        case .unauthorizedClient:
            print("Invalid unauthorized client error")
        case .unsupportedGrantType:
            print("Invalid unsupported grant error")
        case .unknown:
            print("Unknown error")
        @unknown default:
            break
        }

        _authToken.value = nil
    }
}
