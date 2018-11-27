//
//  Dependencies.swift
//  burgershop-finder
//
//  Created by e.vanags on 24/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

protocol Dependencies {
    func apiService() -> APIServiceProtocol
    func authService() -> AuthServiceProtocol
}

final class MainDependencies: Dependencies {

    private let _apiService = APIService()
    func apiService() -> APIServiceProtocol {
        return _apiService
    }

    private let _authService = AuthService()
    func authService() -> AuthServiceProtocol {
        return _authService
    }
}

struct DependencyAssembler {

    private(set) static var dependencies: Dependencies!

    static func register(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

