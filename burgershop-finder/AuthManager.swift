//
//  AuthManager.swift
//  burgershop-finder
//
//  Created by e.vanags on 23/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import UIKit

class AuthManager {

    private var scheme: String {
        return "fsburgershopfinder"
    }

    /// Add this string to your application Redirect URI(s)
    private var callbackURI: String {
        return "fsburgershopfinder://authorized"
    }

    /// Replace clientId and clientSecret with your Foursquare application data
    private let clientId = "client_id"
    private let clientSecret = "client_secret"
    var authToken: String?

    static var shared = AuthManager()

    private init() {}

    func authorize(presenter: UIViewController) -> Bool {
        let statuscode = FSOAuth.shared().authorizeUser(usingClientId: clientId,
                                                        nativeURICallbackString: callbackURI,
                                                        universalURICallbackString: nil,
                                                        allowShowingAppStore: true,
                                                        presentFrom: presenter)
        var resultText: String = ""
        switch(statuscode) {
        case .success:
            return true
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
        return false
    }

    func handle(url: URL) {
        if (url.scheme == scheme) {
            var errorCode: FSOAuthErrorCode = .none
            let accessCode = FSOAuth.shared().accessCode(forFSOAuthURL: url, error: &errorCode)

            if errorCode == .none {
                requestAccessToken(accessCode: accessCode!)
            } else {
                // FIXME: handle error
                print(errorMessageForCode(errorCode: errorCode))
            }
        }
    }

    func requestAccessToken(accessCode: String) {
        FSOAuth.shared().requestAccessToken(forCode: accessCode,
                                            clientId: clientId,
                                            callbackURIString: callbackURI,
                                            clientSecret: clientSecret) { [weak self] (authToken, requestCompleted, errorCode) in
            if requestCompleted {
                if (errorCode == .none) {
                    // FIXME: use authToken!
                    self?.authToken = authToken
                } else {
                    // FIXME: handle error
                    print(self?.errorMessageForCode(errorCode: errorCode) as Any)
                }
            } else {
                print("An error occured when attempting o connect to the Foursquare server.")
            }
        }
    }

    func errorMessageForCode(errorCode: FSOAuthErrorCode) -> String {
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
