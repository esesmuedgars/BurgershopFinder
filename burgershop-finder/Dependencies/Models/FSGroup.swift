//
//  FSGroup.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

typealias FSGroups = [FSGroup]

struct FSGroup: Codable {
    var type: String
    var items: FSItems
}
