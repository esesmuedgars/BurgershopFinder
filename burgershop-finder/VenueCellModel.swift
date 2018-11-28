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

    private var cache: NSCache<NSString, UIImage> {
        return CacheManager.shared.cache
    }

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
         apiService: APIServiceProtocol = DependencyAssembler.dependencies.apiService(),
         authService: AuthServiceProtocol = DependencyAssembler.dependencies.authService()) {
        self.venueId = venueId
        self.apiService = apiService
        self.authService = authService

        addHandlers()
    }

    private func addHandlers() {
        venueDetails.skip(1).subscribe { [weak self] event in
            print("🔻 VenueCellModel.addHandlers() venueDetails.onNext")
            guard let details = event.element, let photos = details?.photos else {
                self?.cacheImage(UIImage(named: "Cheeseburger"))
                return
            }

            if let photo = photos.first {
                self?.cacheImage(UIImage(photo))
            }
        }.disposed(by: disposeBag)
    }

    func inspectVenue() {
        if let image = cache.get(forKey: venueId) {
            print("🔸 VenueCellModel.inspectVenue() cache.get(forKey:)")
            _venueImage.value = image
        } else {
            print("🔸 VenueCellModel.inspectVenue() apiService.inspectVenue(authToken:venueId:)")
            apiService.inspectVenue(authToken: authService.rawToken!, venueId: venueId)
                .subscribe(onNext: { [weak self] details in
                    self?._venueDetails.value = details
                    }, onError: { error in
                        print(error)
                }).disposed(by: disposeBag)
        }
    }

    private func cacheImage(_ image: UIImage?) {
        guard cache.get(forKey: venueId) == nil else { return }
        print("🔹 VenueCellModel.cacheImage(_:)")

        cache.set(image, forKey: venueId)
        _venueImage.value = image
    }
}
