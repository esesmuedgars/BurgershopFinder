//
//  DependencyAssembler.swift
//  burgershop-finder
//
//  Created by e.vanags on 27/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation

struct DependencyAssembler {

    private(set) static var dependencies: Dependencies!

    static func register(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
