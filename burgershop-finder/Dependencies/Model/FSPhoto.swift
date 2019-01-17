//
//  FSPhoto.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

struct FSPhoto: Codable {
    private var groups: FSGroups

    var group: FSGroup? {
        get {
            return groups.first(where: { $0.type == "venue" })
        }
    }

    // TODO: Revisit
    init() {
        self.groups = []
    }
}
