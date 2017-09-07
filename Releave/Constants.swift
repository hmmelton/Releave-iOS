//
//  Constants.swift
//  Releave
//
//  Created by Harrison Melton on 9/5/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import Foundation

// This struct holds constants for the API
struct ReleaveApi {
    private static let root = "https://releave-65906.herokuapp.com"
    
    // API's endpoints
    struct Endpoints {
        static let login = root + "/login"
        static let charge = root + "/charge"
        static let users = root + "/users"
        static let restrooms = root + "/restrooms"
        static let areaRestrooms = root + "/area_restrooms"
    }
    
    // Keys used in requests
    struct RequestKeys {
        static let authHeader = "Authorization"
        static let id = "id"
        static let facebookId = "fb_id"
        static let stripeToken = "stripe_token"
        static let chargeAmount = "amount"
        static let minLat = "min_lat"
        static let maxLat = "max_lat"
        static let minLng = "min_lng"
        static let maxLng = "max_lng"
    }
}

// Constants used as keys for UserDefaults
struct LocalStorage {
    static let facebookAccessToken = "FacebookAccessToken"
}

