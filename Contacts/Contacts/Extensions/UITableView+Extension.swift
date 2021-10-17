//
//  UITableView+Extension.swift
//  Contacts
//
//  Created by Anudeep Gone on 18/10/21.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
