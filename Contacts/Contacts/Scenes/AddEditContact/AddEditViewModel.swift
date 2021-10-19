//
//  AddEditViewModel.swift
//  Contacts
//
//  Created by Anudeep Gone on 17/10/21.
//

import Foundation

class AddEditVieModel {
    
    // MARK: - Private properties
    private let apiService: APIServiceProtocol
    
    // MARK: - Callbacks or observers
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
    
    /**
     To initialize with apiService
     
     - parameter apiService: APIService to make network cal
     */
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
}

extension AddEditVieModel {
    // MARK: - Public methods
    func updateContact(contact: Contact) {
        guard !isLoading else { return }
        
        isLoading = true
        self.apiService.request(router: Router.updateContact(id: contact.id ?? 0, request: contact)) { (result: Result<UpdateResponse, APIError>) in
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
