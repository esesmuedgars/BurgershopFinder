//
//  LocationService.swift
//  burgershop-finder
//
//  Created by e.vanags on 01/10/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa

final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {

    private var locationManager = CLLocationManager()

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.pausesLocationUpdatesAutomatically = false
    }

    private let _authorizationStatus = PublishRelay<CLAuthorizationStatus>()
    var authorizationStatus: Observable<CLAuthorizationStatus> {
        return _authorizationStatus
            .do(onNext: { [locationManager] status in
                if status == .authorizedAlways || status == .authorizedWhenInUse {
                    locationManager.startUpdatingLocation()
                }
            })
            .share(replay: 1, scope: .forever)
    }

    var currentAuthorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    var initialAuthorizationStatus: Single<CLAuthorizationStatus> {
        return Single<CLAuthorizationStatus>.create { [currentAuthorizationStatus] event -> Disposable in
            event(.success(currentAuthorizationStatus))

            return Disposables.create()
        }
    }

    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func setBackgroundAccuracy() {
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }

    func setForegroundAccuracy() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        _authorizationStatus.accept(status)
    }
}
