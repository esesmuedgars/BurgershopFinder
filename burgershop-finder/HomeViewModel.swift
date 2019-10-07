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

final class HomeViewModel {

    private let locationService: LocationServiceProtocol
    private let apiService: APIServiceProtocol
    private let authService: AuthServiceProtocol

    private lazy var userAuthorized = false

    private(set) lazy var disposeBag = DisposeBag()

    public lazy var items = BehaviorRelay(value: FSIdentifiers())

    private(set) lazy var details: BehaviorSubject<FSDetails?> = BehaviorSubject(value: nil)

    let userLocationUpdated: Driver<CLLocationCoordinate2D>

    let userLocationUpdate = PublishSubject<MKUserLocation>()
    let focusLocationTaps = PublishSubject<Void>()

    private let _requestLocationService = ReplaySubject<Void>.create(bufferSize: 1)
    var requestLocationService: Observable<Void> {
        return _requestLocationService.asObservable()
    }

    private let _locationServiceEnabled = ReplaySubject<Bool>.create(bufferSize: 1)
    var locationServiceEnabled: Observable<Bool> {
        return _locationServiceEnabled.asObserver()
    }

    init(locationService: LocationServiceProtocol = Dependencies.shared.locationService(),
         apiService: APIServiceProtocol = Dependencies.shared.apiService(),
         authService: AuthServiceProtocol = Dependencies.shared.authService()) {
        self.locationService = locationService
        self.apiService = apiService
        self.authService = authService

        let initialUserLocation = userLocationUpdate.take(1)

        let focusUserLocation = focusLocationTaps
            .withLatestFrom(userLocationUpdate)

        userLocationUpdated = Observable<MKUserLocation>.merge(initialUserLocation, focusUserLocation)
            .map { $0.coordinate }
            .startWith(.default)
            .asDriver(onErrorJustReturn: .default)

        bindRx()
    }

    private func bindRx() {
        authService.authToken
            .subscribe(onNext: { [weak self] authToken in
                self?.fetchVenues(authToken: authToken!)
            }, onError: { [weak self] error in
                self?.userAuthorized = false
                print(error)
            })
            .disposed(by: disposeBag)

        locationService.authorizationStatus
            .compactMap { status -> Optional<Bool> in
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    return true
                case .notDetermined, .restricted, .denied:
                    return false
                @unknown default:
                    print("`CLAuthorizationStatus` returned unknown value")
                    return nil
                }
            }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isAuthorized in
                if isAuthorized {
                    self?._locationServiceEnabled.onNext(true)
                } else {
                    self?._requestLocationService.onNext(())
                }
            })
            .disposed(by: disposeBag)
    }

    func authorize(_ viewController: UIViewController) {
        if !userAuthorized {
            authService.authorize(viewController)
            userAuthorized = true
        }
    }

    private func fetchVenues(authToken: String) {
        apiService.fetchVenues(authToken: authToken)
            .subscribe(onNext: { [items] venues in
                items.accept(venues)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func cellModel(forVenueWith identifier: String) -> VenueCellModel {
        let cellModel = VenueCellModel(forVenueWith: identifier)
        cellModel.venueDetails.bind(to: details).disposed(by: disposeBag)

        return cellModel
    }
}
