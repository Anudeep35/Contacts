//
//  ContactsViewModelTests.swift
//  ContactsTests
//
//  Created by Anudeep Gone on 19/10/21.
//

import XCTest
@testable import Contacts

class ContactsViewModelTests: XCTestCase {
    
    var sut: ContactsViewModel!
    var mockAPIService: MockAPIService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIService = MockAPIService()
        sut = ContactsViewModel(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
    }
    
    func testinitFetchContacts() throws {
        sut.initFetchContacts()
        XCTAssertFalse(false)
    }
    
    func testNumberOfSections() throws {
        sut.initFetchContacts()
        XCTAssertTrue(sut.numberOfSections == 27)
    }
    
    func testNumberOfRows() throws {
        sut.initFetchContacts()
        //number of rows for A section
        XCTAssert(sut.numberOfRows(in: 0) == 0)
        //number of rows for C section
        XCTAssert(sut.numberOfRows(in: 2) == 1)
    }
    
    func testGetTitleForHeader() throws {
        sut.initFetchContacts()
        XCTAssert(sut.getTitleForHeader(in: 2) == "C")
    }
    
    func testGetContact() throws {
        sut.initFetchContacts()
        XCTAssertNotNil(sut.getContact(at: IndexPath(row: 0, section: 2)))
    }
    
    func testUpdateLoadingStatus() {
        let expect = XCTestExpectation(description: "Loading status updated")
        sut.updateLoadingStatus = {
            expect.fulfill()
        }
        sut.initFetchContacts()
        wait(for: [expect], timeout: 1.0)
    }
    
}
