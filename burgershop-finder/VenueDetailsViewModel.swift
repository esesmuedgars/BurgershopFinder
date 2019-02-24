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
    let phoneNumberLabelAttributedText: Observable<NSAttributedString?>
    let addressLabelAttributedText: Observable<NSAttributedString?>
    let priceLabelAttributedText: Observable<NSAttributedString?>
    let likesLabelAttributedText: Observable<NSAttributedString?>
    let ratingLabelAttributedText: Observable<NSAttributedString?>
    let imageViewImage: Observable<UIImage?>

    init(annotation: PointAnnotation,
         apiService: APIServiceProtocol = Dependencies.shared.apiService()) {
        self.annotation = annotation
        self.apiService = apiService

        titleLabelAttributedText = Observable<String?>
            .just(annotation.title)
            .map { NSAttributedString($0?.capitalized) }

        phoneNumberLabelAttributedText = Observable<String?>
            .just(annotation.phoneNumber)
            .map { NSAttributedString($0) }

        addressLabelAttributedText = Observable<String?>
            .just(VenueDetailsViewModel.combineAddress(from: annotation))
            .map { NSAttributedString($0) }

        priceLabelAttributedText = Observable<Int>
            .just(annotation.priceTier)
            .map {
                let text = Constants.price
                let range = NSRange(location: $0, length: text.count - $0)

                return NSMutableAttributedString(text, range: range)
            }

        likesLabelAttributedText = Observable<Int>
            .just(annotation.likes)
            .map { NSAttributedString($0) }

        ratingLabelAttributedText = Observable<Float>
            .just(annotation.rating)
            .map { NSAttributedString($0) }

        imageViewImage = Observable<UIImage?>
            .just(annotation.image)
    }

    private static func combineAddress(from annotation: PointAnnotation) -> String {
        var completeAddress = [String]()
        var address2ndLine = [String]()
        var address3rdLine = [String]()

        if let county = annotation.county {
            completeAddress.append(county)
        }

        if let address = annotation.address {
            address2ndLine.append(address)
        }

        if let street = annotation.street {
            address2ndLine.append(street)
        }

        if address2ndLine.isNotEmpty {
            let completeAddress2ndLine = address2ndLine.joined(separator: ", ")
            completeAddress.append(completeAddress2ndLine)
        }

        if let countryCode = annotation.countryCode {
            address3rdLine.append(countryCode)
        }

        if let postalCode = annotation.postalCode {
            address3rdLine.append(postalCode)
        }

        if address3rdLine.isNotEmpty {
            let completeAddress3rdLine = address3rdLine.joined(separator: "-")
            completeAddress.append(completeAddress3rdLine)
        }

        return completeAddress.joined(separator: ",\n")
    }
}
