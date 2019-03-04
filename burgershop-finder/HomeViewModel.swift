//
//  HomeViewModel.swift
//  burgershop-finder
//
//  Created by e.vanags on 24/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit
import CoreLocation

final class HomeViewModel {

    private let apiService: APIServiceProtocol
    private let authService: AuthServiceProtocol

    private lazy var userAuthorized = false

    private(set) lazy var disposeBag = DisposeBag()

    private lazy var _items = Variable(FSIdentifiers())
    var items: Observable<FSIdentifiers> {
        return _items.asObservable()
    }

    private(set) lazy var details: BehaviorSubject<FSDetails?> = BehaviorSubject(value: nil)

    let userLocationUpdate = PublishSubject<MKUserLocation>()
    let userLocationUpdated: Driver<CLLocationCoordinate2D>

    init(apiService: APIServiceProtocol = Dependencies.shared.apiService(),
         authService: AuthServiceProtocol = Dependencies.shared.authService()) {
        self.apiService = apiService
        self.authService = authService

        userLocationUpdated = userLocationUpdate.take(1)
            .map { $0.coordinate }
            .startWith(.default)
            .asDriver(onErrorJustReturn: .default)

        bindRx()
    }

    private func bindRx() {
        authService.authToken.subscribe(onNext: { [weak self] authToken in
            self?.fetchVenues(authToken: authToken!)
            }, onError: { [weak self] error in
                self?.userAuthorized = false
                print(error)
        }).disposed(by: disposeBag)
    }

    func authorize(_ viewController: UIViewController) {
        if !userAuthorized {
            authService.authorize(viewController)
            userAuthorized = true
        }
    }

    private func fetchVenues(authToken: String) {
        apiService.fetchVenues(authToken: authToken)
            .subscribe(onNext: { [weak self] items in
                self?._items.value = items
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }

    func cellModel(forVenueWith identifier: String) -> VenueCellModel {
        let cellModel = VenueCellModel(forVenueWith: identifier)
        cellModel.venueDetails.bind(to: details).disposed(by: disposeBag)

        return cellModel
    }
}
