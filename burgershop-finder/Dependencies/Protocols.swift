//
//  Protocols.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/01/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift

protocol Dependencies {
    func authService() -> AuthServiceProtocol
    func apiService() -> APIServiceProtocol
}

protocol AuthServiceProtocol {

    var description: String { get }

    var authToken: Observable<String?> { get }
    var rawToken: String? { get }

    /// Authorize user with Foursquare server.
    /// Will call `application(_:open:options:)` method of `UIApplicationDelegate` subclass on success.
    ///
    /// - Parameter viewController: `UIViewController` subclass which will present `FSOAuth` created WebView.
    func authorize(_ viewController: UIViewController)
    func requestToken(_ url: URL)
}

protocol APIServiceProtocol {

    var description: String { get }

    func fetchVenues(authToken token: String) -> Observable<FSIdentifiers>
    func inspectVenue(authToken token: String, venueId identifier: String) -> Observable<FSDetails>
}
