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

//    private let _apiService = APIService()
    func apiService() -> APIServiceProtocol {
//        return _apiService
        return APIService()
    }

    private let _authService = AuthService()
    func authService() -> AuthServiceProtocol {
        return _authService
    }
}

struct DependencyAssembler {

    // this property shold not be modified externally. Use register(dependencies: )
    private(set) static var dependencies: Dependencies!

    static func register(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

/// Called from AppDelegate of application target.
/// Test targed gets its own registerDependencies() implementation,
/// with its own types (mocks) where needed.
extension DependencyAssembler {

    static func registerDependencies() {
        register(dependencies: MainDependencies())
    }
}
