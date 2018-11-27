//
//  APIService.swift
//  burgershop-finder
//
//  Created by e.vanags on 08/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift

protocol APIServiceProtocol {
    func fetchVenues(authToken token: String) -> Observable<FSIdentifiers>
    func inspectVenue(authToken token: String, venueId identifier: String) -> Observable<FSDetails>
}

final class APIService: APIServiceProtocol {

    func fetchVenues(authToken token: String) -> Observable<FSIdentifiers> {
        let parameters = [URLQueryItem(with: .token, value: token),
                          URLQueryItem(with: .version, value: Constants.version),
                          URLQueryItem(with: .location, value: Constants.location),
                          URLQueryItem(with: .venue, value: Constants.venue),
                          URLQueryItem(with: .limit, value: Constants.limit)]

        let request = Endpoint.search.request(with: parameters)

        return URLSession.shared.rx.response(request: request)
//            .debug(#function)
            .flatMap { arguments -> Observable<FSIdentifiers> in
                let (response, data) = arguments

                guard 200 ..< 300 ~= response.statusCode else {
                    return Observable.error("Expected success status code, but received \(response.statusCode).")
                }

                return Observable<FSIdentifiers>.create { observer -> Disposable in
                    do {
                        observer.onNext(try FSIdentifiers.parse(data: data))
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }

                    return Disposables.create()
                }
        }
    }

    func inspectVenue(authToken token: String, venueId identifier: String) -> Observable<FSDetails> {
        let parameters = [URLQueryItem(with: .token, value: token),
                          URLQueryItem(with: .version, value: Constants.version)]

        let request = Endpoint.details(withIdentifier: identifier).request(with: parameters)

        return URLSession.shared.rx.response(request: request)
//            .debug(#function)
            .flatMap { arguments -> Observable<FSDetails> in
                let (response, data) = arguments

                guard 200 ..< 300 ~= response.statusCode else {
                    return Observable.error("Expected success status code, but received \(response.statusCode).")
                }

                return Observable<FSDetails>.create { observer -> Disposable in
                    do {
                        observer.onNext(try JSONDecoder().decode(FSDetails.self, from: data))
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }

                    return Disposables.create()
                }
        }
    }
}
