//
//  CharacterTableViewCell.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 21/7/21.
//

import UIKit
import Kingfisher

///Definition of the cell for the TableView

class CharacterTableViewCell: UITableViewCell {
    
    let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textColor = .white
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        contentView.addSubview(characterImage)
        characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        contentView.addSubview(characterName)
        characterName.topAnchor.constraint(equalTo: characterImage.topAnchor, constant: 10).isActive = true
        characterName.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 12).isActive = true
        
        
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func prepareHero(with hero: Hero) {
        characterName.text = hero.name
        if let url = URL(string:hero.thumbnail.url) {
            characterImage.kf.setImage(with: url)
        } else {
            characterImage.image = nil
        }
        
        
    }

}
