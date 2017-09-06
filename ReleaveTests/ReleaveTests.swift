//
//  ReleaveTests.swift
//  ReleaveTests
//
//  Created by Harrison Melton on 9/2/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
@testable import Releave

class ReleaveTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUser() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // 1. Given
        let id = "59af1dde420c050011b6b6bf"
        
        // 2. When
        APIUtil.getUser(id) { (result, error) in
            // 3. Then
            
            // Basic result assertions
            XCTAssert(error == nil, "Error was not nil")
            XCTAssert(result != nil, "Result was nil")
            
            // JSON format assertions
            XCTAssert(result!.firstName == "Harrison", "first_name was not 'Harrison'")
            XCTAssert(result!.lastName == "Melton", "last_name was not 'Melton'")
            XCTAssert(result!.email == "hmmelton@comcast.net", "email was not 'hmmelton@comcast.net'")
        }
    }
    
    func testUpdateUser() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
