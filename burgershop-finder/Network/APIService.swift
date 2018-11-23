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

class APIService {

    enum Callback {
        typealias Success = (FSIdentifiers) -> Void
        typealias Successs = (Data) -> Void
        typealias Fail = (String?) -> Void
    }

    static let shared = APIService()

    private init() {}

    func fetchVenues(success: @escaping Callback.Success, fail: @escaping Callback.Fail) {
        let parameters = [URLQueryItem(with: .clientId, value: Constants.identifier),
                          URLQueryItem(with: .clientSecret, value: Constants.secret),
                          URLQueryItem(with: .version, value: Constants.version),
                          URLQueryItem(with: .location, value: "Tallin"),
                          URLQueryItem(with: .venue, value: "Burger Joint"),
                          URLQueryItem(with: .limit, value: "20")]

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
        let parameters = [URLQueryItem(with: .clientId, value: Constants.identifier),
                          URLQueryItem(with: .clientSecret, value: Constants.secret),
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
                let details = try JSONDecoder().decode(FSDetails.self, from: data)
                print(details.response.venue.id)
                // FIXME:
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
