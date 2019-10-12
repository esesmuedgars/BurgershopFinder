//
//  Endpoint.swift
//  burgershop-finder
//
//  Created by e.vanags on 08/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

enum Endpoint {
    case search
    case details(withIdentifier: String)

    private var rawValue: String {
        get {
            switch self {
            case .search:
                return "search"
            case .details(let identifier):
                return identifier
            }
        }
    }

    private var base: String {
        return "https://api.foursquare.com/v2/venues"
    }
}

enum Parameter: String {
    case token = "oauth_token"
    case version = "v"
    case location = "near"
    case venue = "query"
    case limit = "limit"
}

extension URLQueryItem {
    init(with parameter: Parameter, value: String?) {
        self.init(name: parameter.rawValue, value: value)
    }
}

extension Endpoint {
    func url() -> URL {
        var url = URL(string: base)!
        url.appendPathComponent(rawValue)
        return url
    }

    func request(with parameters: [URLQueryItem]) -> URLRequest {
        var components = URLComponents(url: url(), resolvingAgainstBaseURL: false)!
        components.queryItems = parameters

        return URLRequest(url: components.url!)
    }
}
