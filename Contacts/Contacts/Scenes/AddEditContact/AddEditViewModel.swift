//
//  AddEditViewModel.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import Foundation

class AddEditVieModel {
    
    let apiService: APIServiceProtocol
    
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
    var dismiss: (()->())?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
}

extension AddEditVieModel {
    func updateContact(contact: Contact) {
        guard !isLoading else { return }
        
        isLoading = true
        self.apiService.request(router: Router.updateContact(id: contact.id ?? 0), parameters: contact) { (result: Result<Contact, APIError>) in
            switch result {
            case .success( _):
                self.dismiss?()
            case .failure(let error):
                self.alertMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
}
