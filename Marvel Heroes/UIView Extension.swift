//
//  UIView Extension.swift
//  Marvel Heroes
//
//  Created by f.rosales.lopera on 27/7/21.
//

import UIKit

extension UIView {
    
    ///Function for create a gradient
    /// - Parameters:
    /// - frame: CGRect for the size of the gradient
    
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
