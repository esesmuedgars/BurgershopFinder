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

final class VenueCellModel {

    let venueId: String

    private let apiService: APIServiceProtocol
    private let authService: AuthServiceProtocol

    private(set) lazy var disposeBag = DisposeBag()

    private lazy var _venueDetails: Variable<FSDetails?> = Variable(nil)
    var venueDetails: Observable<FSDetails?> {
        return _venueDetails.asObservable()
    }

    init(forVenueWith venueId: String,
         apiService: APIServiceProtocol = DependencyAssembler.dependencies.apiService(),
         authService: AuthServiceProtocol = DependencyAssembler.dependencies.authService()) {
        self.venueId = venueId
        self.apiService = apiService
        self.authService = authService
    }

    func inspectVenue() {
        apiService.inspectVenue(authToken: authService.rawToken!, venueId: venueId)
            .subscribe(onNext: { [weak self] details in
                self?._venueDetails.value = details
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
