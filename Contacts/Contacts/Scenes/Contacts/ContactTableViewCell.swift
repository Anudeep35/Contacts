//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.circleCorner(applyBorder: false)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
    }
    
    func updateCell(contact: Contact) {
        nameLabel.text = contact.fullName
        avatarImageView.loadAvatar(avatar: contact.avatar)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
