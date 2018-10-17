//
//  Identifiers.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

typealias Identifier = String
typealias Identifiers = [Identifier]

extension Array where Element == Identifier {
    static func parse(data: Data) throws -> Identifiers {
        guard let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let response = object["response"] as? [String: Any],
            let venues = response["venues"] as? [[String: Any]] else {
                throw "Unable to parse provided data as Identifiers type class."
        }

        return venues.map { $0["id"] as! String }
    }
}
