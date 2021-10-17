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
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.gradientTop.cgColor, UIColor.gradientBotttom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
