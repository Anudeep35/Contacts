//
//  UIImageView+Extension.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadAvatar(avatar: String?) {
        guard let urlString = avatar,
              let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        APIService.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                self.image = UIImage(named: "avatar_placeholder")
            }
        }
    }
    
    func circleCorner(applyBorder: Bool = true) {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        if applyBorder {
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.white.cgColor
        }
    }
}
