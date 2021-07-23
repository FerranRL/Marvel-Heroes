//
//  DetailViewController.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 22/7/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIStackView()
    
    let header: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
    }()
    let body = UIView()
    
    var hero: Hero!
    
    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bg-Detail")

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_peque")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 260).isActive = true
        return imageView
    }()
    
    let heroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupdata()
        setupScrollView()
        setupContentView()
        setupHeader()
    }
    
    private func setupdata() {
        if let url = URL(string: (hero?.thumbnail.url)!) {
            heroImageView.kf.setImage(with: url)
        } else {
            heroImageView.image = nil
        }
        
        heroLabel.text = hero.name
    }
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.applyGradient(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    private func setupContentView() {
        
        contentView.axis = .vertical
        contentView.distribution = .fill
        contentView.alignment = .fill
        
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
    }
    
    private func setupHeader(){
        
        
        header.addSubview(headerImageView)
        let screenSize: CGRect = UIScreen.main.bounds
        headerImageView.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
        headerImageView.clipsToBounds = true
        headerImageView.contentMode = .scaleToFill
        
        header.addSubview(logoImageView)
        logoImageView.topAnchor.constraint(equalTo: header.topAnchor, constant: 20).isActive = true
        logoImageView.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: -20).isActive = true
        
        header.addSubview(heroImageView)
        heroImageView.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor).isActive = true
        heroImageView.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor).isActive = true
        
        header.addSubview(heroLabel)
        heroLabel.centerXAnchor.constraint(equalTo: heroImageView.centerXAnchor).isActive = true
        heroLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 25).isActive = true
        heroLabel.adjustsFontSizeToFitWidth = true
        heroLabel.minimumScaleFactor = 0.5
        
        
        contentView.addArrangedSubview(header)
        header.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        
    }


}
