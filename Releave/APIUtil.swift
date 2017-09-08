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
    
    // Authorization header used by all requests
    static let headers: [String:String] = [ReleaveApi.RequestKeys.authHeader : SecretKeys.authToken]
    
    // MARK: Users
    
    // This function gets an individual user
    static func getUser(_ id: String, completion: @escaping (User?, Error?) -> ()) {
        
        // Format URL with query parameters
        let url = "\(ReleaveApi.Endpoints.users)/\(id)"
        
        // Send GET request to server
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
            
            guard let result = response.result.value as! Dictionary<String, Any>? else {
                // Could not fetch response data - return error to completion handler
                print(response.error)
                completion(nil, response.error)
                return
            }
                
            // Convert result to User object and return to completion handler
            print(result)
            completion(User(JSON(result)), nil)
        }
    }
    
    // This function creates a new user
    static func createUser(_ body: Parameters, completion: @escaping (User?, Error?) -> ()) {
        
        // Set up URL
        let url = ReleaveApi.Endpoints.users
        
        // Send POST request to server
        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            
            guard let result = response.result.value as! Dictionary<String, Any>? else {
                // Failure fetching status code - return error to completion handler
                completion(nil, response.error)
                return
            }
            
            // Convert result to User object and return to completion handler
            completion(User(JSON(result)), nil)
        }
    }
    
    // This function updates an individual user
    static func updateUser(_ id: String, withUpdatedInfo body: Parameters, completion: @escaping (User?, Error?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.users)/\(id)"
        
        // Send PUT request to server
        Alamofire.request(url, method: .put, parameters: body, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            
            guard let result = response.result.value as! Dictionary<String, Any>? else {
                // Failure fetching status code - return error to completion handler
                completion(nil, response.error)
                return
            }

            // Convert result to User object and return to completion handler
            completion(User(JSON(result)), nil)
        }
    }
    
    // This function deletes an individual user
    static func deleteUser(_ id: String, completion: @escaping (Bool?, Error?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.users)/\(id)"
        
    }
    
}
