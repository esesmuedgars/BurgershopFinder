//
//  MainDependencies.swift
//  burgershop-finder
//
//  Created by e.vanags on 24/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

final class MainDependencies: Dependencies {

    private let _authService = AuthService()
    func authService() -> AuthServiceProtocol {
        return _authService
    }

    private let _apiService = APIService()
    func apiService() -> APIServiceProtocol {
        return _apiService
    }
}
