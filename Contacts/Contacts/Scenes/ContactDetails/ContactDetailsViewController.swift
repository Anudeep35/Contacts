//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import UIKit

class ContactDetailsViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.circleCorner()
        }
    }
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var contactIdLabel: UILabel!
    
    // MARK: - Properties
    var contact: Contact?
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.setGradientBackground()
    }
    
    // MARK: - IBActions methods
    @IBAction func onclickEdit(_ sender: Any) {
        presentEditContact()
    }
    
}

extension ContactDetailsViewController {
    // MARK: - Private methods
    func setUI() {
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.navigationController?.navigationBar.tintColor = .theme
        clearNavigationBottomBorderColor()
    }
    
    func updateUI() {
        guard let contact = contact else {
            return
        }
        nameLable.text = contact.fullName
        contactIdLabel.text = contact.contactId
        avatarImageView.loadAvatar(avatar: contact.avatar)
    }
}

extension ContactDetailsViewController {
    // MARK: - Table view data source & delegates

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ContactDetailsViewController {
    // MARK: - Navigation
    private func presentEditContact() {
        guard let addEditVC = storyboard?.instantiateViewController(withIdentifier: "AddEditContactViewController") as? AddEditContactViewController else {
            return
        }
        addEditVC.contact = contact
        let navigationVC = UINavigationController(rootViewController: addEditVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: false, completion: nil)
    }
}
