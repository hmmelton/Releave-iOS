//
//  ReleaveAPITests.swift
//  Releave
//
//  Created by Harrison Melton on 9/6/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
@testable import Releave

class ReleaveAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUserSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // 1. Given
        let id = "59af1dde420c050011b6b6bf"
        
        let promise = expectation(description: "Status: 200")
        
        var result: User?
        var error: Error?
        
        // 2. When
        APIUtil.getUser(id) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        //waitForExpectations(timeout: 60, handler: nil)
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        
        // Basic result assertions
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result != nil, "Result was nil")
        
        // JSON format assertions
        XCTAssert(result!.firstName == "Harrison", "first_name was not 'Harrison'")
        XCTAssert(result!.lastName == "Melton", "last_name was not 'Melton'")
        XCTAssert(result!.email == "hmmelton95@gmail.com", "email was not 'hmmelton95@gmail.com'")
    }
    
    func testCreateUserSuccess() {
        // 1. Given
        
        let body = [
            "first_name" : "Octavius",
            "last_name" : "Rex",
            "email" : "o.rex@gmail.com",
            "facebook_id" : 3827238129393,
            "paid" : true,
            "paid_exp": 83892929,
            "stripe_token" : "32kjjf3k2jlfkl32j39fdsak329hr3j2-12i"
        ] as [String : Any]
        
        let promise = expectation(description: "Status 201")
        
        var result: User?
        var error: Error?
        
        // 2. When
        APIUtil.createUser(body) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        //waitForExpectations(timeout: 20, handler: nil)
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result != nil, "Result was not true")
        
        XCTAssert(result!.firstName == "Octavius", "first_name was not 'Octavius'")
        XCTAssert(result!.lastName == "Rex", "last_name was not 'Rex'")
        XCTAssert(result!.email == "o.rex@gmail.com", "email was not 'o.rex@gmail.com'")
        XCTAssert(result!.facebookId == "3827238129393", "facebook_id was not '3827238129393'")
        XCTAssert(result!.paid!, "paid was not true")
        XCTAssert(result!.paidExp! == 83892929, "paid_exp was not '83892929'")
        XCTAssert(result!.stripeToken! == "32kjjf3k2jlfkl32j39fdsak329hr3j2-12i",
                  "stripe_token was not '32kjjf3k2jlfkl32j39fdsak329hr3j2-12i'")
    }
    
    func testUpdateUserEmailSuccess() {
        // 1. Given
        let id = "59af1dde420c050011b6b6bf"
        
        let promise = expectation(description: "Status: 200")
        
        var result: User?
        var error: Error?
        
        // 2. When
        APIUtil.updateUser(id, withUpdatedInfo: ["email" : "hmmelton95@gmail.com"]) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        //waitForExpectations(timeout: 20, handler: nil)
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result != nil, "Result was nil")
        print("\n\n\(result)\n\n")
        XCTAssert(result!.email == "hmmelton95@gmail.com", "email was not hmmelton95@gmail.com")
    }
    
}
