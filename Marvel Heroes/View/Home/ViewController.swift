//
//  ViewController.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 20/7/21.
//

import UIKit
import Lottie

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
    let animationView = AnimationView(name: "loader")
    var firstLoad = true
    
    
    
    let headerView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg_home_header")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 500).isActive = true

        return imageView
    }()
    
    let homeImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "logo_heroes")
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.heightAnchor.constraint(equalToConstant: 162).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 270).isActive = true
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
        homeImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -60).isActive = true
        homeImageView.layer.cornerRadius = 10
        homeImageView.clipsToBounds = true
        
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
        list.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
        
    }
    
    func loadHeroes() {
        loadingHeroes = true
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        let loadingView = LoaderView(frame: CGRect(x: 0, y: self.view.bounds.height - 80, width: self.view.bounds.width, height: 80))
        loadingView.backgroundColor = UIColor(named: "MarvelRed")
        
        if firstLoad {
            view.addSubview(blurredEffectView)
            lottieAnimation()
        } else {
            UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve, animations: {
                self.view.addSubview(loadingView)
            }, completion: nil)
            
        }
        
        
        MarvelAPi.loadHeroes(name: self.name, page: self.currentPage) { (info) in
            if let info = info {
                self.heroes += info.data.results
                self.total = info.data.total
                DispatchQueue.main.async {
                    
                    self.loadingHeroes = false
                    UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve, animations: {
                        self.animationView.removeFromSuperview()
                        blurredEffectView.removeFromSuperview()
                    }, completion: nil)
                    self.tableView.reloadData()
                    UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve, animations: {
                        loadingView.removeFromSuperview()
                    }, completion: nil)
                    
                }
            }
        }
        
    }
    
    func lottieAnimation() {
        
        animationView.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .loop
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
        
        var hero:[Hero] = []
        let heroId = heroes[indexPath.row].id
        
        MarvelAPi.loadHero(id: heroId) { info in
            hero = info!.data.results
            let storyboard: UIStoryboard = UIStoryboard(name: "DetailStoryBoard", bundle: nil)
            let detailController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
            detailController.hero = hero[0]
            self.present(detailController, animated: true, completion: nil)
        }
 
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == heroes.count - 1 && !loadingHeroes && heroes.count != total {
            currentPage += 1
            firstLoad = false
            
            loadHeroes()
        }
    }
    
}





