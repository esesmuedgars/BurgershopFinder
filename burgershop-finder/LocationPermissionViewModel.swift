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

    let descriptionText = "We'll help you find your nearest burger venues in Tallin."

    private let _buttonTitle = PublishSubject<String>()
    var buttonTitle: Observable<String> {
        return _buttonTitle.asObservable()
    }

    let disposeBag = DisposeBag()

    init(locationService: LocationServiceProtocol = Dependencies.shared.locationService()) {
        self.locationService = locationService
    }

    func fetchValues() {
        locationService.initialAuthorizationStatus
            .subscribe(onSuccess: { [_buttonTitle] status in
                switch status {
                case .notDetermined:
                    _buttonTitle.onNext("Enable location services")
                case .authorizedAlways, .authorizedWhenInUse:
                    // self dismiss
                    break
                case .restricted, .denied:
                    _buttonTitle.onNext("Open settings")
                @unknown default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }

    func requestAuthorization() {
        // TODO:
        // check state, request authorization or open settings
        locationService.requestAuthorization()
    }
}
