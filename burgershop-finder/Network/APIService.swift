//
//  APIService.swift
//  burgershop-finder
//
//  Created by e.vanags on 08/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

extension String: Error {}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

protocol APIServiceProtocol {
    func fetchVenues(success: @escaping APIService.Callback.Success, fail: @escaping APIService.Callback.Fail)
    func inspectVenue(with identifier: String, success: @escaping APIService.Callback.Successs, fail: @escaping APIService.Callback.Fail)

    // #debug
    func inspectVenue(with token: String)
}

final class APIService: APIServiceProtocol {

    enum Callback {
        typealias Success = (FSIdentifiers) -> Void
        typealias Successs = (Data) -> Void
        typealias Fail = (String?) -> Void
    }


    func fetchVenues(success: @escaping Callback.Success, fail: @escaping Callback.Fail) {
        let parameters = [URLQueryItem(with: .identifier, value: Constants.identifier),
                          URLQueryItem(with: .secret, value: Constants.secret),
                          URLQueryItem(with: .version, value: Constants.version),
                          URLQueryItem(with: .location, value: Constants.location),
                          URLQueryItem(with: .venue, value: Constants.venue),
                          URLQueryItem(with: .limit, value: Constants.limit)]

        let request = Endpoint.search.request(with: parameters)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                    throw "Fetch venues API call returned no data."
                }

                guard 200 ..< 300 ~= response.statusCode else {
                    throw "Expected success status code, but received \(response.statusCode)."
                }

                success(try FSIdentifiers.parse(data: data))
            } catch {
                fail(error.localizedDescription.errorDescription)
            }
        }.resume()
    }

    func inspectVenue(with identifier: String, success: @escaping Callback.Successs, fail: @escaping Callback.Fail) {
        let parameters = [URLQueryItem(with: .identifier, value: Constants.identifier),
                          URLQueryItem(with: .secret, value: Constants.secret),
                          URLQueryItem(with: .version, value: Constants.version)]

        let request = Endpoint.details(withIdentifier: identifier).request(with: parameters)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                    throw "Inspect venue API call returned no data."
                }

                guard 200 ..< 300 ~= response.statusCode else {
                    throw "Expected success status code, but received \(response.statusCode)."
                }
                // FIXME:
                let details = try JSONDecoder().decode(FSDetails.self, from: data)
                print(details.response.venue.id)
            } catch {
                fail(error.localizedDescription.errorDescription)
            }
        }.resume()
    }

    // #debug
    func inspectVenue(with token: String) {
        let string = "https://api.foursquare.com/v2/venues/57ab6aac38fa3daa126ddd6f?oauth_token=\(token)&v=20180929"
        let url = URL(string: string)!
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (_, response, _) in
            guard let response = response as? HTTPURLResponse else { return }
            print(response)
        }.resume()
    }
}
