//
//  Constants.swift
//  burgershop-finder
//
//  Created by e.vanags on 24/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

struct Constants {

    static var scheme: String {
        return "fsburgershopfinder"
    }

    /// Add `callbackURI` string to your application `Redirect URI(s)`.
    static var callbackURI: String {
        return "fsburgershopfinder://authorized"
    }

    /// Replace placeholder with your Foursquare application `Client ID` string.
    static var identifier: String {
        return "<#Client ID#>"
    }

    /// Replace placeholder with your Foursquare application `Client Secret` string.
    static var secret: String {
        return "<#Client Secret#>"
    }

    static var version: String {
        return "20180927"
    }

    static var location: String {
        return "Tallin"
    }

    static var venue: String {
        return "Burger Joint"
    }

    static var limit: String {
        return "12"
    }

    static var price: String {
        return "€€€"
    }
}
