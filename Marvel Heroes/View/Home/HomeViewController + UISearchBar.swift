//
//  HomeViewController + UISearchBar.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 29/7/21.
//

import UIKit

extension ViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        self.allHeroes = self.heroes
        self.heroes = []
        let nameSearch = searchBar.searchTextField.text
        MarvelViewModel.loadHeroes(name: nameSearch, page: self.currentPage) { (info) in
            if let info = info {
                self.heroes += info.data.results
                self.total = info.data.total
                DispatchQueue.main.async {
                    
                    self.loadingHeroes = false
                    self.tableView.reloadData()
                    
                    
                }
            }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            DispatchQueue.main.async {
                self.searchHeroes.resignFirstResponder()
            }
            self.heroes = self.allHeroes
            self.loadingHeroes = false
            self.tableView.reloadData()
            
        }
    }
    
  
}
