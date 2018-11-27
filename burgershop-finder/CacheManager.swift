//
//  CacheManager.swift
//  burgershop-finder
//
//  Created by e.vanags on 27/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import UIKit

struct CacheManager {

    static private(set) var shared = CacheManager()

    let cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 100
    }
}
