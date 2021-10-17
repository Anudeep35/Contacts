//
//  AddEditContactViewController.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import UIKit

class AddEditContactViewController: UITableViewController {
    
    //MARK: - Enums
    enum InputFields: CaseIterable {
        case avatar, firstName, lastName, mobile, email
        static func numberOfRows() -> Int {
            return self.allCases.count
        }
    }

    // MARK: - IBOutlets
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    // MARK: - Private properties
    private lazy var viewModel: AddEditVieModel = {
        return AddEditVieModel()
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let _activityIndicator  = UIActivityIndicatorView()
        _activityIndicator.color = .gray
        _activityIndicator.hidesWhenStopped = true
        _activityIndicator.translatesAutoresizingMaskIntoConstraints = true
        tableView.addSubview(_activityIndicator)
        _activityIndicator.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        _activityIndicator.autoresizingMask = [
            .flexibleLeftMargin,
            .flexibleRightMargin,
            .flexibleTopMargin,
            .flexibleBottomMargin
        ]
        return _activityIndicator
    }()
    
    // MARK: - Properties
    var contact: Contact?
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        initAddEditViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.setGradientBackground()
    }

    // MARK: - IBActions methods
    @IBAction func onclickCancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func onclickDone(_ sender: Any) {
        view.endEditing(true)
        viewModel.updateContact(contact: Contact(id: contact?.id, firstName: firstNameTF.text, lastName: lastNameTF.text, avatar: nil, email: nil))
    }

}

extension AddEditContactViewController {
    // MARK: - ViewModel Initialization
    func initAddEditViewModel() {
        viewModel.showAlert = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                }else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.dismiss = { [weak self] () in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.dismiss(animated: false, completion: nil)
            }
        }
    }
}

extension AddEditContactViewController {
    // MARK: - Private methods
    private func setUI() {
        self.tableView.tableFooterView = UIView(frame: .zero)
        clearBottomBorderColor()
        doneBarButton.isEnabled = false
        [firstNameTF, lastNameTF, mobileTF, emailTF].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        setContact()
    }
    
    private func setContact() {
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
    // MARK: - Table view data source & delegates

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
    // MARK: - TextField delegates
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
