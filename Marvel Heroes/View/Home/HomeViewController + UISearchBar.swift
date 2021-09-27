//
//  HomeViewController + UISearchBar.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 29/7/21.
//

import UIKit

var modelView = HomeViewModel()


extension ViewController: UISearchBarDelegate {
    
    ///Function when searchButton is tapped
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        self.allHeroes = self.heroes
        self.heroes = []
        let nameSearch = searchBar.searchTextField.text
        
        ///Function for execute the search of the word typed in searchBar
        /// - Parameters:
        /// - name: The text value of the searchBar
        /// - page: Value for pagination
        
        viewModel.searchHeroes(name: nameSearch, page: self.currentPage) { (result) in
            if result {
                self.heroes = self.viewModel.searchInfo.data.results
                self.total = self.viewModel.searchInfo.data.total
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
