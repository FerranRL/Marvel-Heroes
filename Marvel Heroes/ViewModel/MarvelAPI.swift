//
//  MarvelAPI.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 22/7/21.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPi {
    
    ///Load all Heroes
    class func loadHeroes(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * Constants.limit
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))"
        } else {
            startsWith = ""
        }
        
        let url = Constants.basePath + "?offset=\(offset)&limit=\(Constants.limit)&" + startsWith + getCredentials()
        print(url)
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
    
    ///Load character by Id
    class func loadHero(id: Int, onComplete: @escaping (MarvelInfo?) -> Void ) {
        
        
        let url = Constants.basePath + "/\(id)?" + getCredentials()
        print(url)
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
    
    private class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+Constants.privateKey+Constants.publicKey).lowercased()
        return "&ts=\(ts)&apikey=\(Constants.publicKey)&hash=\(hash)"
    }
    
}
