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
import GoogleMaps
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
    
    // MARK: User Tests

    func testGetUserSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // 1. Given
        let id = "59af1dde420c050011b6b6bf"
        
        let promise = expectation(description: "Status: 200")
        
        var result: User?
        var error: APIError?
        
        // 2. When
        APIUtil.getUser(id) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
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
        
        let body: [String : Any] = [
            "first_name" : "Octavius",
            "last_name" : "Rex",
            "email" : "o.rex@gmail.com",
            "facebook_id" : 3827238129393,
            "paid" : true,
            "paid_exp": 83892929,
            "stripe_token" : "32kjjf3k2jlfkl32j39fdsak329hr3j2-12i"
        ]
        
        let promise = expectation(description: "Status 201")
        
        var result: User?
        var error: APIError?
        
        // 2. When
        APIUtil.createUser(body) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
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
        var error: APIError?
        
        // 2. When
        APIUtil.updateUser(id, withUpdatedInfo: ["email" : "hmmelton95@gmail.com"]) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result != nil, "Result was nil")
        XCTAssert(result!.email == "hmmelton95@gmail.com", "email was not hmmelton95@gmail.com")
    }
    
    func testDeleteUserSuccess() {
        // 1. Given
        // Change this each time to point to dummy user
        let id = "59b378aac99d23001225a39a"
        
        let promise = expectation(description: "Status: 200")
        
        var result: Bool?
        var error: APIError?
        
        // 2. When
        APIUtil.deleteUser(id) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result!, "Result was not true")
    }
    
    // MARK: Restrooms
    
    func testGetRestroomSuccess() {
        // 1. Given
        let id = "59ae1410a86e440011ecf5bb"
        
        let promise = expectation(description: "Status: 200")
        
        var result: Restroom?
        var error: APIError?
        
        // 2. When
        APIUtil.getRestroom(id) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        
        // Basic result assertions
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result != nil, "Result was nil")
        
        // JSON format assertions
        XCTAssert(result!.name == "Chelsea Market", "name was not 'Chelsea Market'")
        XCTAssert(!result!.verified, "verified was not false")
        XCTAssert(result!.lat == 40.7373571, "lat was not '40.7373571'")
        XCTAssert(result?.lng == -74.0025464, "lng was not '74.0025464'")
    }
    
    func testCreateRestroomSuccess() {
        // 1. Given
        
        let body: [String : Any] = [
            "user_id" : "123hmm",
            "lat" : 45.123456,
            "lng" : -74.123456,
            "name" : "Test Restroom",
            "free" : true,
            "verified": true,
            "rating" : 4.6,
            "num_ratings": 46,
            "rating_comment": "This restroom is v clean"
        ]
        
        let promise = expectation(description: "Status 201")
        
        var result: Restroom?
        var error: APIError?
        
        // 2. When
        APIUtil.createRestroom(body) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result != nil, "Result was nil")
        
        XCTAssert(result!.userId == "123hmm", "user_id was not 'Octavius'")
        XCTAssert(result!.lat == 45.123456, "lat was not '45.123456'")
        XCTAssert(result!.lng == -74.123456, "lng was not '-74.123456'")
        XCTAssert(result!.name == "Test Restroom", "name was not 'Test Restroom'")
        XCTAssert(result!.free, "free was not true")
        XCTAssert(result!.verified, "verified was not true")
        XCTAssert(result!.rating == 4.6, "rating was not '4.6'")
        XCTAssert(result!.numberOfRatings == 46, "num_ratings was not '46'")
        XCTAssert(result!.ratingComment == "This restroom is v clean", "rating_comment was not 'This restroom is v clean'")
    }
    
    func testUpdateRestroomNameSuccess() {
        // 1. Given
        let id = "59b1e82f33e0720012022777"
        
        let promise = expectation(description: "Status: 200")
        
        var result: Restroom?
        var error: APIError?
        
        // 2. When
        APIUtil.updateRestroom(id, withUpdatedInfo: ["name" : "West Village Starbucks"]) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result != nil, "Result was nil")
        XCTAssert(result!.name == "West Village Starbucks", "name was not 'West Village Starbucks'")
    }
    
    func testDeleteRestroomSuccess() {
        // 1. Given
        // Change this each time to point to dummy user
        let id = "59ae144ba86e440011ecf5bc"
        
        let promise = expectation(description: "Status: 200")
        
        var result: Bool?
        var error: APIError?
        
        // 2. When
        APIUtil.deleteRestroom(id) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result!, "Result was not true")
    }
    
    func testGetAreaRestroomsSuccess() {
        // 1. Given
        
        // Set latitudes and longitudes
        let northLat = CLLocationDegrees(exactly: 47.584)!
        let southLat = CLLocationDegrees(exactly: 47.583)!
        let eastLng = CLLocationDegrees(exactly: -122.099)!
        let westLng = CLLocationDegrees(exactly: -122.1)!
        
        // Combine above constants to create coordinates
        let northEast = CLLocationCoordinate2D(latitude: northLat, longitude: eastLng)
        let southWest = CLLocationCoordinate2D(latitude: southLat, longitude: westLng)
        
        let promise = expectation(description: "Status: 200")
        
        var result: [Restroom]?
        var error: APIError?
        
        // 2. When
        APIUtil.getAreaRestrooms(northEast: northEast, southWest: southWest) { (r, e) in
            result = r
            error = e
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 20)
        
        // 3. Then
        XCTAssert(error == nil, "Error was not nil")
        XCTAssert(result != nil, "Result was nil")
        
        XCTAssert(result!.count == 3, "Size of restroom array was not 3")
    }
    
}
