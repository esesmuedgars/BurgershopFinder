//
//  FSIdentifier.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

typealias FSIdentifier = String
typealias FSIdentifiers = [FSIdentifier]

extension Array where Element == FSIdentifier {
    static func parse(data: Data) throws -> FSIdentifiers {
        guard let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let response = object["response"] as? [String: Any],
            let venues = response["venues"] as? [[String: Any]] else {
                throw "Unable to parse provided data as `FSIdentifier` type class."
        }

        return venues.map { $0["id"] as! String }
    }
}
