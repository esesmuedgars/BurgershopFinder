//
//  TestDependencies.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/01/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation

final class TestDependencies: Dependencies {

    private let _authService = AuthServiceStub()
    func authService() -> AuthServiceProtocol {
        return _authService
    }

    private let _apiService = APIServiceStub()
    func apiService() -> APIServiceProtocol {
        return _apiService
    }
}
