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
    
    // The only header that is set for all requests is the API key
    let headers: [String : String] = [ReleaveApi.RequestKeys.authHeader : SecretKeys.authToken]
    
    // MARK: Users
    
    // This function gets an individual user
    static func getUser(_ id: String, completion: @escaping (User?, Error?) -> ()) {
        // Create URL including query parameters
        let url = URL(string: ReleaveApi.Endpoints.users + "?\(ReleaveApi.RequestKeys.id)=\(id)" )!
        
        var urlRequest = URLRequest(url: url)
        // Add Authorization header to URL
        urlRequest.addValue(SecretKeys.authToken, forHTTPHeaderField: ReleaveApi.RequestKeys.authHeader)
        
        // Send GET request to server
        Alamofire.request(urlRequest).responseJSON { response in
            if let data = response.result.value as! Dictionary<String, Any>? {
                completion(User(JSON(data)), nil)
            }
        }
    }
    
    // This function updates an individual user
    static func updateUser(_ id: String, withUpdatedInfo body: Parameters, completion: @escaping (Bool?, Error?) -> ()) {
        
    }
    
}
