//
//  HomeViewModel.swift
//  burgershop-finder
//
//  Created by e.vanags on 24/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift

final class HomeViewModel {

    private let apiService: APIServiceProtocol
    private let authService: AuthServiceProtocol

    private lazy var userAuthorized = false

    private(set) lazy var disposeBag = DisposeBag()

    private lazy var _items = Variable(FSIdentifiers())
    var items: Observable<FSIdentifiers> {
        return _items.asObservable()
    }

    init(apiService: APIServiceProtocol = DependencyAssembler.dependencies.apiService(),
         authService: AuthServiceProtocol = DependencyAssembler.dependencies.authService()) {
        self.apiService = apiService
        self.authService = authService

        authService.authToken.skip(1)
            .map { authToken -> Bool in
                return authToken != nil
            }.subscribe { [weak self] event in
                self?.fetchVenues()
//                self?.userAuthorized = event.element!
            }.disposed(by: disposeBag)
    }

    func authorize(_ viewController: UIViewController) {
        if !userAuthorized {
            authService.authorize(viewController)
            userAuthorized = true
        }
    }

    private func fetchVenues() {
        apiService.fetchVenues(authToken: authService.rawToken!)
            .subscribe(onNext: { [weak self] items in
                self?._items.value = items
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
