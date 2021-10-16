//
//  ContactsViewModel.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import Foundation
import UIKit

class ContactsViewModel {
    
    let apiService: APIServiceProtocol
    private var contacts: [Contact] = [Contact]()
    
    private var contactSections: [ContactSection] = [ContactSection]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlert?()
        }
    }
    
    var updateLoadingStatus: (()->())?
    var showAlert: (()->())?
    var reloadTableView: (()->())?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
}

extension ContactsViewModel {
    func initFetchContacts() {
        guard !isLoading else { return }
        
        isLoading = true
        self.apiService.request(router: Router.getContacts(page: 1), parameters: nil) { (result: Result<ServiceResponse, APIError>) in
            switch result {
            case .success(let contacts):
                self.contacts = contacts.data
                self.processContacts()
            case .failure(let error):
                self.alertMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    private func processContacts() {
        let sortedContacts = contacts.sorted(by: { $0.fullName < $1.fullName })
        
        let sectionTitles = UILocalizedIndexedCollation.current().sectionTitles
        
        var _contactsections: [ContactSection] = []
        
        for title in sectionTitles {
            let contacts = sortedContacts.filter({ $0.fullName.capitalized.hasPrefix(title)})
            let section = ContactSection.init(sectionTitle: title, contacts: contacts)
            _contactsections.append(section)
        }
        self.contactSections = _contactsections
    }
    
    var numberOfSections: Int {
        return contactSections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return contactSections[section].contacts.count
    }
    
    func getTitleForHeader(in section: Int) -> String? {
        if contactSections[section].contacts.count == 0 {
            return nil
        }
        return contactSections[section].sectionTitle
    }
    
    func getSectionIndexTitles() -> [String]? {
        return contactSections.compactMap({ $0.sectionTitle })
    }
    
    func getContact(at indexPath: IndexPath) -> Contact {
        return contactSections[indexPath.section].contacts[indexPath.row]
    }
}
