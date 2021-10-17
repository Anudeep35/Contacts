//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: ContactsViewModel = {
        return ContactsViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initContactViewModel()
        viewModel.initFetchContacts()
    }

    @IBAction func onclickAdd(_ sender: Any) {
        presentAddContact()
    }
    
}

extension ContactsViewController {
    func initContactViewModel() {
        
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
        
        viewModel.reloadTableView = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitleForHeader(in: section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.getSectionIndexTitles()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushToContactDetails(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
        let contact = viewModel.getContact(at: indexPath)
        cell.nameLabel.text = contact.fullName
        return cell
    }
}

extension ContactsViewController {
    // MARK: - Navigation
    func pushToContactDetails(for indexPath:IndexPath) {
        guard let contactDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ContactDetailsViewController") as? ContactDetailsViewController else {
            return
        }
        contactDetailsVC.contact = viewModel.getContact(at: indexPath)
        navigationController?.pushViewController(contactDetailsVC, animated: true)
    }

    func presentAddContact() {
        guard let addEditVC = storyboard?.instantiateViewController(withIdentifier: "AddEditContactViewController") as? AddEditContactViewController else {
            return
        }
        let navigationVC = UINavigationController(rootViewController: addEditVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: false, completion: nil)
    }
}

