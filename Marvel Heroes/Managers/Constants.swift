//
//  Constants.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 20/7/21.
//

import Foundation

struct Constants {
    
    static let basePath = "https://gateway.marvel.com/v1/public/characters"
    static let privateKey = ProcessInfo.processInfo.environment["MARVEL_PRIVATE_KEY"]
    static let publicKey = ProcessInfo.processInfo.environment["MARVEL_PUBLIC_KEY"]
    static let limit = 50
    static let application = "application/json"
    static let data = "data"
    static let results = "results"
}
