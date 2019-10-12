//
//  FSContact.swift
//  burgershop-finder
//
//  Created by e.vanags on 15/02/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

struct FSContact: Codable {
    var phoneNumber: String?

    private enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone"
    }
}
