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

    private(set) lazy var disposeBag = DisposeBag()

    let titleAttributedText: Observable<NSAttributedString?>
    let phoneNumberAttributedText: Observable<NSAttributedString?>
    let noPhoneNumber: Observable<Bool>
    let addressAttributedText: Observable<NSAttributedString?>
    let priceAttributedText: Observable<NSAttributedString?>
    let likesAttributedText: Observable<NSAttributedString?>
    let ratingAttributedText: Observable<NSAttributedString?>
    let imageViewImage: Observable<UIImage?>

    init(annotation: PointAnnotation) {
        titleAttributedText = Observable<String?>
            .just(annotation.title)
            .map { NSAttributedString($0?.capitalized) }

        phoneNumberAttributedText = Observable<String?>
            .just(VenueDetailsViewModel.formatPhoneNumber(from: annotation))
            .map { NSAttributedString($0) }

        noPhoneNumber = Observable<String?>
            .just(annotation.phoneNumber)
            .map { $0.isEmptyOrNil }

        addressAttributedText = Observable<String?>
            .just(VenueDetailsViewModel.formatAddress(from: annotation))
            .map { NSAttributedString($0) }

        priceAttributedText = Observable<Int>
            .just(annotation.priceTier)
            .map {
                let text = Constants.price
                let range = NSRange(location: $0, length: text.count - $0)

                return NSMutableAttributedString(text, range: range)
            }

        likesAttributedText = Observable<Int>
            .just(annotation.likes)
            .map { NSAttributedString($0) }

        ratingAttributedText = Observable<Float>
            .just(annotation.rating)
            .map {
                if $0.isZero {
                    return NSAttributedString(Int($0))
                } else {
                    return NSAttributedString($0)
                }
            }

        imageViewImage = Observable<UIImage?>
            .just(annotation.image)
    }

    private static func formatPhoneNumber(from annotation: PointAnnotation) -> String? {
        guard let rawPhoneNumber = annotation.phoneNumber,
            rawPhoneNumber.count == 12 else {
                return nil
        }

        var completePhoneNumber = [Substring]()

        let phoneNumber = rawPhoneNumber
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()

        var length = 3
        let countryCode = phoneNumber.prefix(length)
        completePhoneNumber.append(countryCode)

        if let component = phoneNumber.substring(start: length, offsetBy: 2) {
            completePhoneNumber.append(component)
            length += component.count
        }

        for _ in 0 ... 1 {
            if let component = phoneNumber.substring(start: length, offsetBy: 3) {
                completePhoneNumber.append(component)
                length += component.count
            }
        }

        return String(format: "+%@", completePhoneNumber.joined(separator: " "))
    }

    private static func formatAddress(from annotation: PointAnnotation) -> String {
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
