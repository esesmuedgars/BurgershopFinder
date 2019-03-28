//
//  VenueCellModel.swift
//  burgershop-finder
//
//  Created by e.vanags on 27/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class VenueCellModel {

    private let venueId: String
    private let apiService: APIServiceProtocol
    private let authService: AuthServiceProtocol

    private(set) lazy var disposeBag = DisposeBag()

    private lazy var _venueDetails: Variable<FSDetails?> = Variable(nil)
    var venueDetails: Observable<FSDetails?> {
        return _venueDetails.asObservable()
    }

    private lazy var _venueImage: Variable<UIImage?> = Variable(UIImage(named: "Cheeseburger"))
    var venueImage: Observable<UIImage?> {
        return _venueImage.asObservable()
    }

    init(forVenueWith venueId: String,
         apiService: APIServiceProtocol = Dependencies.shared.apiService(),
         authService: AuthServiceProtocol = Dependencies.shared.authService()) {
        self.venueId = venueId
        self.apiService = apiService
        self.authService = authService

        bindRx()
    }

    private func bindRx() {
        venueDetails.skip(1)
            .subscribe(onNext: { [_venueImage] details in
                guard let image = details?.image else {
                    _venueImage.value = UIImage(named: "Cheeseburger")
                    return
                }

                _venueImage.value = image
            })
            .disposed(by: disposeBag)
    }

    func inspectVenue() {
        apiService.inspectVenue(authToken: authService.rawToken!, venueId: venueId)
            .subscribe(onNext: { [_venueDetails] details in
                _venueDetails.value = details
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
