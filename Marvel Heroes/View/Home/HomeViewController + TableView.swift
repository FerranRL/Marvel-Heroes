//
//  HomeViewController + TableView.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 27/7/21.
//

import UIKit

let viewModel = HomeViewModel()

///Extension for the TableView

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.heroes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        let hero = heroes[indexPath.row]
        cell.prepareHero(with: hero)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let heroId = heroes[indexPath.row].id
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "DetailStoryBoard", bundle: nil)
        let detailController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailController.heroId = heroId
        self.present(detailController, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == heroes.count - 20 && !loadingHeroes && heroes.count != total {
            currentPage += 1
            firstLoad = false
            
            loadHeroes()
        }
    }
    
}
