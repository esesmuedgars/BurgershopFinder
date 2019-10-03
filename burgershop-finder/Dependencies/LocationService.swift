//
//  LocationService.swift
//  burgershop-finder
//
//  Created by e.vanags on 01/10/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {

    private var locationManager = CLLocationManager() {
        didSet {
            locationManager.delegate = self
        }
    }

    private let _authorizationStatus = PublishRelay<CLAuthorizationStatus>()
    var authorizationStatus: Observable<CLAuthorizationStatus> {
        return _authorizationStatus.asObservable()
    }

    var initialAuthorizationStatus: Single<CLAuthorizationStatus> {
        return Single<CLAuthorizationStatus>.create { event -> Disposable in
            let authorizationStatus = CLLocationManager.authorizationStatus()
            event(.success(authorizationStatus))

            return Disposables.create()
        }
    }

    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        _authorizationStatus.accept(status)
    }
}
