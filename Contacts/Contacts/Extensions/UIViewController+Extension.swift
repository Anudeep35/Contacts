//
//  UIViewController+Extension.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import Foundation
import UIKit

enum NavigationType {
    case present
    case push
}

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func clearNavigationBottomBorderColor() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    func navigate(to destinationVC: UIViewController, type: NavigationType) {
        if type == .present {
            let navigationVC = UINavigationController(rootViewController: destinationVC)
            navigationVC.modalPresentationStyle = .fullScreen
            self.present(navigationVC, animated: false, completion: nil)
        } else {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

extension UIStoryboard {
    func instantiate<T>() -> T? {
        guard let vc = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            return nil
        }
        return vc
    }
}

