//
//  FSItem.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

typealias FSItems = [FSItem]

struct FSItem: Codable {
    private var prefix: String
    private var suffix: String

    var url: URL {
        get {
            return URL(string: String(format: "%@original%@", prefix, suffix))!
        }
    }
}
