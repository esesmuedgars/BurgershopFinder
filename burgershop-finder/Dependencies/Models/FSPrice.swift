//
//  FSPrice.swift
//  burgershop-finder
//
//  Created by e.vanags on 15/02/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation

struct FSPrice: Codable {
    private enum Level: Int {
        case cheap = 1
        case moderate
        case expensive

        var verbose: String {
            switch self {
            case .cheap:
                return "€"
            case .moderate:
                return "€€"
            case .expensive:
                return "€€€"
            }
        }
    }

    private var tier: Int

    var level: String {
        let level = Level(rawValue: tier) ?? .cheap
        return level.verbose
    }
}
