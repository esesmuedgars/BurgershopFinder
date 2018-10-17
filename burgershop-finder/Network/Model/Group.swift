//
//  Group.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

typealias Groups = [Group]

struct Group: Codable {
    var type: String
    var items: Items
}
