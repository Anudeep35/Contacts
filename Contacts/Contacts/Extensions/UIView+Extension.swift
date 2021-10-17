//
//  UIView+Extension.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground() {
        let colorTop =  UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 214.0/255.0, green: 249.0/255.0, blue: 241.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
