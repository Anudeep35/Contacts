//
//  AddEditContactViewModelTests.swift
//  ContactsTests
//
//  Created by Anudeep Gone on 20/10/21.
//

import XCTest
@testable import Contacts

class AddEditContactViewModelTests: XCTestCase {
    
    var sut: AddEditVieModel!
    var mockAPIService: MockAPIService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIService = MockAPIService()
        sut = AddEditVieModel(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
    }

}
