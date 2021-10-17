//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import UIKit

class ContactDetailsViewController: UITableViewController {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var contactIdLabel: UILabel!
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.setGradientBackground()
    }
    @IBAction func onclickEdit(_ sender: Any) {
        presentEditContact()
    }
    
}

extension ContactDetailsViewController {
    func setUI() {
        self.tableView.tableFooterView = UIView(frame: .zero)
        clearBottomBorderColor()
    }
    
    func updateUI() {
        guard let contact = contact else {
            return
        }
        nameLable.text = contact.fullName
        contactIdLabel.text = contact.contactId
    }
}

extension ContactDetailsViewController {
    // MARK: - Table view data source

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
    func presentEditContact() {
        guard let addEditVC = storyboard?.instantiateViewController(withIdentifier: "AddEditContactViewController") as? AddEditContactViewController else {
            return
        }
        addEditVC.contact = contact
        let navigationVC = UINavigationController(rootViewController: addEditVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: false, completion: nil)
    }
}
