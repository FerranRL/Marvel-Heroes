//
//  LoaderView.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 26/7/21.
//

import UIKit

class LoaderView: UIView {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = Constants.loaderText
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView() {
        self.addSubview(label)
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
}
