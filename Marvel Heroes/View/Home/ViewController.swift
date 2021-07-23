//
//  ViewController.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 20/7/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let contentView = UIStackView()
    
    let header = UIView()
    let list = UIView()
    let tableView = UITableView()
    
    var heroes: [Hero] = []
    var name: String?
    var loadingHeroes: Bool = false
    var currentPage: Int  = 0
    var total = 0
    
    
    let fakedata = ["Spider-Man", "Batman", "Iron Man"]
    
    let headerView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg_home_header")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let homeImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "logo_marvel_header")
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue, UIColor.black]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect.zero
        return gradientLayer
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContentView()
        setupHeader()
        setupTableView()
        loadHeroes()
        
    }
    
    private func setupContentView() {
        
        contentView.axis = .vertical
        contentView.distribution = .fill
        contentView.alignment = .fill
        contentView.backgroundColor = UIColor(named: "Blue2")

        
        view.addSubview(contentView)
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    private func setupHeader() {
        
        header.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: header.trailingAnchor).isActive = true
        
        header.addSubview(homeImageView)
        homeImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        homeImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        header.clipsToBounds = true
        contentView.addArrangedSubview(header)
        header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.3/3).isActive = true
        
    }
    
    private func setupTableView() {
        
        list.applyGradient(frame: view.bounds)
        
        list.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: list.topAnchor, constant: 8).isActive = true
        tableView.leadingAnchor.constraint(equalTo: list.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: list.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: list.bottomAnchor).isActive = true
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        contentView.addArrangedSubview(list)
        
        
    }
    
    func loadHeroes() {
        loadingHeroes = true
        MarvelAPi.loadHeroes(name: name, page: currentPage) { (info) in
            if let info = info {
                self.heroes += info.data.results
                self.total = info.data.total
                print(self.total)
                print(self.heroes.count)
                DispatchQueue.main.async {
                    self.loadingHeroes = false
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension UIView {
    func applyGradient(frame: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.type = .radial
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        let color1 = UIColor(named: "Blue1")
        let color2 = UIColor(named: "Blue2")
        gradient.colors = [color1?.cgColor as Any, color2?.cgColor as Any]
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.heroes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
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
        print("Tap en la celda de \(heroes[indexPath.row].name)")
        
        let storyboard: UIStoryboard = UIStoryboard(name: "DetailStoryBoard", bundle: nil)
        let detailController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailController.hero = heroes[indexPath.row]
        self.present(detailController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == heroes.count - 10 && !loadingHeroes && heroes.count != total {
            currentPage += 1
            loadHeroes()
        }
    }
    
}





