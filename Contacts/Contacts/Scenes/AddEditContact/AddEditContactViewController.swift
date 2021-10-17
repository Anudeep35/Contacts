//
//  AddEditContactViewController.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import UIKit

class AddEditContactViewController: UITableViewController {
    
    enum InputFields: CaseIterable {
        case avatar, firstName, lastName, mobile, email
        static func numberOfRows() -> Int {
            return self.allCases.count
        }
    }

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.setGradientBackground()
    }

    @IBAction func onclickCancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func onclickDone(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }

}

extension AddEditContactViewController {
    func setUI() {
        self.tableView.tableFooterView = UIView(frame: .zero)
        clearBottomBorderColor()
        doneBarButton.isEnabled = false
        [firstNameTF, lastNameTF, mobileTF, emailTF].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        setContact()
    }
    
    func setContact() {
        guard let contact = contact else {
            return
        }
        firstNameTF.text = contact.firstName
        lastNameTF.text = contact.lastName
        mobileTF.text = contact.contactId
        emailTF.text = contact.email
        [mobileTF, emailTF].forEach({$0?.isEnabled = false })
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard let firstName = firstNameTF.text, !firstName.isEmpty,
              let lastName = lastNameTF.text, !lastName.isEmpty else {
            doneBarButton.isEnabled = false
            return
        }
        doneBarButton.isEnabled = true
    }
}

extension AddEditContactViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InputFields.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AddEditContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag: Int = textField.tag + 1
        guard let nextResponder = tableView?.viewWithTag(nextTag) else {
            textField.resignFirstResponder()
            return true
        }
        nextResponder .becomeFirstResponder()
        return false
    }
}
