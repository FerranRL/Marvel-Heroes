//
//  Loader.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 26/7/21.
//

import UIKit

class loaderView: UIViewController {
    
    let contentView = UIStackView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private func setupContentView() {
        contentView.axis = .vertical
        contentView.distribution = .fill
        contentView.alignment = .center
        
        view.addSubview(contentView)
        
    }
    
}
