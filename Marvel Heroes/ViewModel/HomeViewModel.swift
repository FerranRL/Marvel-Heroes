//
//  MarvelViewModel.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 27/9/21.
//

import Foundation


class HomeViewModel {
    
    
    var marvelInfo: MarvelInfo!
    var marvelError: MarvelError!
    var searchInfo: MarvelInfo!
    
    /// Request for all heros to API
    /// Parameters:
    /// - name: Optional value for searching
    /// - page: Pagination
    
    func loadAllHeroes(name: String?, page: Int = 0, completion: @escaping (Bool) -> Void ) {
        MarvelAPI.loadHeroes(name: name, page: page) { info, error in
            if info != nil {
                self.marvelInfo = info
                completion(true)
                
            } else if error != nil {
                self.marvelError = error
                completion(false)
            }
        }
    }
    
    /// Request for search Hero by name
    /// Parameters:
    /// - name: Optional value for searching
    /// - page: Pagination
    
    func searchHeroes(name: String?, page: Int = 0, completion: @escaping (Bool) -> Void ) {
        MarvelAPI.searchHeroes(name: name, page: page) { (search, error) in
            if search != nil {
                self.searchInfo = search
                completion(true)
            } else if error != nil {
                self.marvelError = error
                completion(false)
            }
        }
    }
    

    
}


