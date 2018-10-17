//
//  Photo.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

struct Photo: Codable {
    private var groups: Groups

    var group: Group {
        get {
            return groups.first(where: { $0.type == "venue" })!
        }
    }
}
