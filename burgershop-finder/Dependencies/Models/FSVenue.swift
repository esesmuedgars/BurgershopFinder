//
//  FSVenue.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

struct FSVenue: Codable {
    var id: String
    var name: String
    var contact: FSContact
    var location: FSLocation
    var price: FSPrice?
    var likes: FSLikes
    var rating: Float?
    var photo: FSPhoto

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case contact
        case location
        case price
        case likes
        case rating
        case photo = "photos"
    }
}
