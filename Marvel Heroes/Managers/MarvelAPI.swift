//
//  MarvelAPI.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 22/7/21.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {
    
    ///Load all Heroes from the API
    /// - Parameters:
    /// - name: Optional value for searching by name
    /// - page: Value for pagination
    class func loadHeroes(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?, MarvelError?) -> Void) {
        
        let offset = page * Constants.limit
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))"
        } else {
            startsWith = ""
        }
        
        let url = Constants.basePath + "?offset=\(offset)&limit=\(Constants.limit)&" + startsWith + getCredentials()
        AF.request(url).responseJSON { (response) in
            guard let data = response.data,
                  let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data),
                  marvelInfo.code == 200 else {
                      print(response)
                      guard let data = response.data, response.data != nil else { return }
                      let errorMessage = try? JSONDecoder().decode(MarvelError.self, from: data)
                      onComplete(nil, errorMessage)
                      return
                  }
            onComplete(marvelInfo, nil)
        }
    }
    
    ///Search heros by name
    /// - Parameters:
    /// - name: Value for searching by name
    /// - page: Value for pagination
    
    class func searchHeroes(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?, MarvelError?) -> Void) {
        
        let offset = page * Constants.limit
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))"
        } else {
            startsWith = ""
        }
        
        let url = Constants.basePath + "?offset=\(offset)&limit=\(Constants.limit)&" + startsWith + getCredentials()
        AF.request(url).responseJSON { (response) in
            guard let data = response.data,
                  let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data),
                  marvelInfo.code == 200 else {
                print(response)
                guard let data = response.data, response.data != nil else { return }
                let errorMessage = try? JSONDecoder().decode(MarvelError.self, from: data)
                onComplete(nil, errorMessage)
                return
            }
            onComplete(marvelInfo, nil)
        }
    }
    
    
    ///Load character by Id
    /// - Parameters:
    /// - id: Id of the hero.
    class func loadHero(id: Int, onComplete: @escaping (MarvelInfo?) -> Void ) {
        
        
        let url = Constants.basePath + "/\(id)?" + getCredentials()
        AF.request(url).responseJSON { (response) in
            guard let data = response.data,
                  let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data),
                  marvelInfo.code == 200 else {
                onComplete(nil)
                return
            }
            onComplete(marvelInfo)
        }
    }
    
    /// Create credentials for the request
    
    private class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+Constants.privateKey+Constants.publicKey).lowercased()
        print("&ts=\(ts)&apikey=\(Constants.publicKey)&hash=\(hash)")
        return "&ts=\(ts)&apikey=\(Constants.publicKey)&hash=\(hash)"
    }
    
}
