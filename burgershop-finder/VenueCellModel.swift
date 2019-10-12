//
//  VenueCellModel.swift
//  burgershop-finder
//
//  Created by e.vanags on 27/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class VenueCellModel {

    private let venueId: String
    private let apiService: APIServiceProtocol
    private let authService: AuthServiceProtocol

    private(set) lazy var disposeBag = DisposeBag()

    public lazy var venueDetails: BehaviorRelay<FSDetails?> = BehaviorRelay(value: nil)
    public lazy var venueImage: BehaviorRelay<UIImage?> = BehaviorRelay(value: .default)

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
            .subscribe(onNext: { [venueImage] details in
                guard let image = details?.image else {
                    venueImage.accept(.default)
                    return
                }

                venueImage.accept(image)
            })
            .disposed(by: disposeBag)
    }

    func inspectVenue() {
        apiService.inspectVenue(authToken: authService.rawToken!, venueId: venueId)
            .subscribe(onNext: { [venueDetails] details in
                venueDetails.accept(details)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
