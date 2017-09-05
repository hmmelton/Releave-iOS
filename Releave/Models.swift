//
//  Models.swift
//  Releave
//
//  Created by Harrison Melton on 9/4/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import Foundation
import SwiftyJSON

// Struct to represent a User object
struct User {
    var id: String
    var facebookId: String
    var firstName: String
    var lastName: String
    var email: String
    var paid: Bool?
    var paidExp: Int64?
    var stripeToken: String?
    
    // Parse passed JSON object to initialize stored properties
    init(_ json: JSON) {
        id = json["id"].stringValue
        facebookId = json["facebook_id"].stringValue
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        email = json["email"].stringValue
        paid = json["paid"].bool
        paidExp = json["paid_exp"].int64
        stripeToken = json["stripe_token"].string
    }
}

// Struct to represent a Restroom object
struct Restroom {
    var id: String
    var userId: String
    var lat: Double
    var lng: Double
    var name: String
    var free: Bool
    var verified: Bool
    var rating: Double
    var numberOfRatings: Int
    var ratingComment: String?
    
    // Parse passed JSON object to initialize stored properties
    init(_ json: JSON) {
        id = json["id"].stringValue
        userId = json["user_id"].stringValue
        lat = json["lat"].doubleValue
        lng = json["lng"].doubleValue
        name = json["name"].stringValue
        free = json["free"].boolValue
        verified = json["verified"].boolValue
        rating = json["rating"].doubleValue
        numberOfRatings = json["num_ratings"].intValue
        ratingComment = json["rating_comment"].string
    }
}
