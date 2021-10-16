//
//  UIViewController+Extension.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

