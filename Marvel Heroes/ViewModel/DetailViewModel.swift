//
//  DetailViewModel.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 27/9/21.
//

import Foundation

class DetailViewModel {
    
    var heroInfo: MarvelInfo!
    
    /// Request for a Hero by Id to API
    /// Parameters:
    /// - id: Id for the selected hero
    
    func loadHero(id: Int, completion: @escaping (Bool) -> Void) {
        MarvelAPI.loadHero(id: id) { info in
            if info != nil {
                self.heroInfo = info
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
