//
//  APIServiceStub.swift
//  burgershop-finder
//
//  Created by e.vanags on 17/01/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import Foundation
import RxSwift

// TODO: Revisit
final class APIServiceStub: APIServiceProtocol {

    var description: String {
        return "application programming interface service stub"
    }

    func fetchVenues(authToken token: String) -> Observable<FSIdentifiers> {
        // TODO: Mock observable
        return Variable(FSIdentifiers()).asObservable()
    }

    func inspectVenue(authToken token: String, venueId identifier: String) -> Observable<FSDetails> {
        // TODO: Mock observable
        return Variable(FSDetails()).asObservable()
    }
}
