//
//  VenueDetailsViewModel.swift
//  burgershop-finder
//
//  Created by e.vanags on 13/02/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class VenueDetailsViewModel {

    private let annotation: PointAnnotation
    private let apiService: APIServiceProtocol

    private(set) lazy var disposeBag = DisposeBag()

    let titleLabelAttributedText: Observable<NSAttributedString?>
    let imageViewImage: Observable<UIImage?>

    init(annotation: PointAnnotation,
         apiService: APIServiceProtocol = Dependencies.shared.apiService()) {
        self.annotation = annotation
        self.apiService = apiService

        titleLabelAttributedText = Observable<String?>
            .just(annotation.title)
            .map { NSAttributedString($0) }

        imageViewImage = Observable<UIImage?>
            .just(annotation.image)
    }
}
