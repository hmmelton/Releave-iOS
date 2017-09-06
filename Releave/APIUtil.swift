//
//  APIUtil.swift
//  Releave
//
//  Created by Harrison Melton on 9/4/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIUtil {
    
    // The only parameter that is set for all requests is the API key
    private static var parameters: Parameters =
        [ReleaveApi.RequestKeys.authKey : SecretKeys.authToken]
    
    // MARK: Users
    
    // This function gets an individual user
    static func getUser(_ id: String, completion: @escaping (User?, Error?) -> ()) {
        // Add request-specific parameters
        var localParams: Parameters = parameters
        localParams[ReleaveApi.RequestKeys.id] = id
        
        // Send GET request to server
        Alamofire.request(ReleaveApi.Endpoints.users, method: .get, parameters: localParams, encoding: JSONEncoding.default).responseJSON { response in
            if let data = response.result.value as! String? {
                completion(User(JSON(parseJSON: data)), nil)
            }
        }
    }
    
    // This function updates an individual user
    static func updateUser(_ id: String, withUpdatedInfo body: Parameters, completion: @escaping (Bool?, Error?) -> ()) {
        
    }
    
}
