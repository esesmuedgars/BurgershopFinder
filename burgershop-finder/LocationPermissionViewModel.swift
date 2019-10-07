//
//  LocationPermissionViewModel.swift
//  burgershop-finder
//
//  Created by e.vanags on 01/10/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LocationPermissionViewModel {

    private let locationService: LocationServiceProtocol

    let descriptionText = "We'll help you find burger venues in Tallin. Grant permission to have your location displayed."

    private let _buttonTitle = BehaviorSubject<String>(value: "")
    var buttonTitle: Observable<String> {
        return _buttonTitle.asObservable()
    }

    private let _authorized = ReplaySubject<Void>.create(bufferSize: 1)
    var authorized: Observable<Void> {
        return _authorized.asObservable()
    }

    let disposeBag = DisposeBag()

    init(locationService: LocationServiceProtocol = Dependencies.shared.locationService()) {
        self.locationService = locationService

        bindRx()
    }

    private func bindRx() {
        Observable.merge(locationService.initialAuthorizationStatus.asObservable(), locationService.authorizationStatus)
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .notDetermined:
                    self._buttonTitle.onNext("Enable location services")
                case .authorizedAlways, .authorizedWhenInUse:
                    self._authorized.onNext(())
                case .restricted, .denied:
                    self._buttonTitle.onNext("Open settings")
                @unknown default:
                    print("`CLAuthorizationStatus` returned unknown value")
                }
            })
            .disposed(by: disposeBag)
    }

    func requestAuthorizationOrOpenSettings() {
        switch locationService.currentAuthorizationStatus {
        case .notDetermined:
            locationService.requestAuthorization()
        case .restricted, .denied:
            let settings = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(settings)
        default:
            break
        }
    }
}
