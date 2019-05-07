//
//  VenueDetailsViewModel.swift
//  burgershop-finder
//
//  Created by e.vanags on 13/02/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation

final class VenueDetailsViewModel {

    let titleText: String?
    let phoneNumberText: String?
    let noPhoneNumber: Bool
    let addressText: String
    let priceAttributedText: NSAttributedString
    let likesText: String
    let ratingText: String
    let image: UIImage?

    init(annotation: PointAnnotation) {
        titleText = annotation.title?.capitalized

        phoneNumberText = VenueDetailsViewModel.formatPhoneNumber(from: annotation)

        noPhoneNumber = annotation.phoneNumber.isEmptyOrNil

        addressText = VenueDetailsViewModel.formatAddress(from: annotation)

        let priceTier = annotation.priceTier
        let text = Constants.price
        let range = NSRange(location: priceTier, length: text.count - priceTier)
        priceAttributedText = NSMutableAttributedString(text, range: range)

        likesText = String(annotation.likes)

        ratingText = annotation.rating.isZero ? String(Int(annotation.rating)) : String(annotation.rating)

        image = annotation.image
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
