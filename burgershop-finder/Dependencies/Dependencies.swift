//
//  Dependencies.swift
//  burgershop-finder
//
//  Created by e.vanags on 24/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

final class Dependencies {

    private(set) static var shared = Dependencies()

    private let _authService = AuthService()
    func authService() -> AuthServiceProtocol {
        return _authService
    }

    private let _apiService = APIService()
    func apiService() -> APIServiceProtocol {
        return _apiService
    }

    private let _locationService = LocationService()
    func locationService() -> LocationServiceProtocol {
        return _locationService
    }
}
