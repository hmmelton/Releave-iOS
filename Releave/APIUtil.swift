//
//  APIUtil.swift
//  Releave
//
//  Created by Harrison Melton on 9/4/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import Foundation
import Alamofire
import GoogleMaps
import SwiftyJSON

class APIUtil {
    
    // Authorization header used by all requests
    static let headers: [String:String] = [ReleaveApi.RequestKeys.authHeader : SecretKeys.authToken]
    
    // MARK: Users
    
    static func login(_ facebookId: String, withBody body: Parameters, completion: @escaping (User?, APIError?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.login)/\(facebookId)"
        
        // Send GET request to server
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            // Format server response
            let (json, error): (JSON?, APIError?) = formatDataResponse(response: response, withDataType: Dictionary<String, Any>.self)
        
            if error?.statusCode == 404 {
                // User does not exist, so make a new one
                createUser(body, completion: completion)
            } else {
                // There was no 404 error - return response to completion handler
                completion(json == nil ? nil : User(json!), error)
                return
            }
        }
    }
    
    // This function retrieves an individual user
    static func getUser(_ id: String, completion: @escaping (User?, APIError?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.users)/\(id)"
        
        // Send GET request to server
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
            
                // Format server response
                let (json, error) = formatDataResponse(response: response, withDataType: Dictionary<String, Any>.self)
                // Return response to completion handler
                completion(json == nil ? nil : User(json!), error)
        }
    }
    
    // This function creates a new user
    static func createUser(_ body: Parameters, completion: @escaping (User?, APIError?) -> ()) {
        
        // Set up URL
        let url = ReleaveApi.Endpoints.users
        
        // Send POST request to server
        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            
            // Format server response
            let (json, error) = formatDataResponse(response: response, withDataType: Dictionary<String, Any>.self)
            // Return response to completion handler
            completion(json == nil ? nil : User(json!), error)
        }
    }
    
    // This function updates an individual user
    static func updateUser(_ id: String, withUpdatedInfo body: Parameters, completion: @escaping (User?, APIError?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.users)/\(id)"
        
        // Send PUT request to server
        Alamofire.request(url, method: .put, parameters: body, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            
            // Format server response
            let (json, error) = formatDataResponse(response: response, withDataType: Dictionary<String, Any>.self)
            // Return response to completion handler
            completion(json == nil ? nil : User(json!), error)
        }
    }
    
    // This function deletes an individual user
    static func deleteUser(_ id: String, completion: @escaping (Bool?, APIError?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.users)/\(id)"
        
        // Send DELETE request to server
        Alamofire.request(url, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                
                // Analyze network response
                let (status, error) = formatStatusResponse(response)
                // Return info to completion handler
                completion(status, error)
        }
    }
    
    // MARK: Restrooms
    
    // This function retrieves an individual restroom
    static func getRestroom(_ id: String, completion: @escaping (Restroom?, APIError?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.restrooms)/\(id)"
        
        // Send GET request to server
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                
                // Format server response
                let (json, error) = formatDataResponse(response: response, withDataType: Dictionary<String, Any>.self)
                // Return response to completion handler
                completion(json == nil ? nil : Restroom(json!), error)
        }
    }
    
    // This function creates a new restroom
    static func createRestroom(_ body: Parameters, completion: @escaping (Restroom?, APIError?) -> ()) {
        
        // Set up URL
        let url = ReleaveApi.Endpoints.restrooms
        
        // Send POST request to server
        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.httpBody, headers: headers)
            .responseJSON { response in
                
                // Format server response
                let (json, error) = formatDataResponse(response: response, withDataType: Dictionary<String, Any>.self)
                // Return response to completion handler
                completion(json == nil ? nil : Restroom(json!), error)
        }
    }
    
    // This function updates an individual restroom
    static func updateRestroom(_ id: String, withUpdatedInfo body: Parameters, completion: @escaping (Restroom?, APIError?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.restrooms)/\(id)"
        
        // Send PUT request to server
        Alamofire.request(url, method: .put, parameters: body, encoding: URLEncoding.httpBody, headers: headers)
            .responseJSON { response in
                // Format server response
                let (json, error) = formatDataResponse(response: response, withDataType: Dictionary<String, Any>.self)
                // Return response to completion handler
                completion(json == nil ? nil : Restroom(json!), error)
            }
    }
    
    // This function deletes an individual restroom
    static func deleteRestroom(_ id: String, completion: @escaping (Bool?, APIError?) -> ()) {
        
        // Format URL with parameter
        let url = "\(ReleaveApi.Endpoints.restrooms)/\(id)"
        
        // Send DELETE request to server
        Alamofire.request(url, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                
                // Analyze network response
                let (status, error) = formatStatusResponse(response)
                // Return info to completion handler
                completion(status, error)
        }
    }
    
    // This function retrieves all restrooms in a given area
    static func getAreaRestrooms(northEast: CLLocationCoordinate2D, southWest: CLLocationCoordinate2D,
                                 completion: @escaping ([Restroom]?, APIError?) -> ()) {
        
        // Set up URL
        let url = ReleaveApi.Endpoints.areaRestrooms
        // Set parameters
        let parameters: [String : Any] = [
            ReleaveApi.RequestKeys.minLat : southWest.latitude,
            ReleaveApi.RequestKeys.maxLat : northEast.latitude,
            ReleaveApi.RequestKeys.minLng : southWest.longitude,
            ReleaveApi.RequestKeys.maxLng : northEast.longitude
        ]
        
        // Send GET request to server
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .responseJSON { response in
                
                // Format server response
                let (json, error) = formatDataResponse(response: response, withDataType: Array<Dictionary<String, Any>>.self)
                
                if error != nil {
                    // There was an error - return it to the completion handler
                    completion(nil, error)
                } else {
                    // Data was returned
                    // Initialize empty Restroom array
                    var restroomArray: [Restroom] = []
                    // Convert returned JSON to an array
                    let jsonArray = json!.arrayValue
                    
                    // Iterate through array of JSON objects adding each to Restroom array
                    for restroom in jsonArray {
                        restroomArray.append(Restroom(restroom))
                    }
                    
                    // Return data to completion handler
                    completion(restroomArray, nil)
                }
        }
    }
    
    // MARK: Helpers
    
    // This function parses a network request result, returning the appropriate value or error.
    private static func formatDataResponse<T>(response: DataResponse<Any>, withDataType: T.Type) -> (JSON?, APIError?) {
        guard let result = response.result.value as! T?, let status = response.response?.statusCode else {
            // Failure reaching server - return error to completion handler
            return (nil, APIError(statusCode: 503, description: "Failure reaching server"))
        }
        
        if 200 ... 299 ~= status {
            // Convert result to object of type T and return
            return (JSON(result), nil)
        } else {
            // Failure updating object
            return (nil, APIError(statusCode: status, description: JSON(result)["error"].stringValue))
        }
    }
    
    // This function analyzes a network request response code, returning the appropriate information.
    private static func formatStatusResponse(_ response: DataResponse<Any>) -> (Bool?, APIError?) {
        guard let status = response.response?.statusCode else {
            // Failure reaching server - return error to
            return (nil, APIError(statusCode: 503, description: "Failure reaching server"))
        }
        
        // Tell completion handler whether or not deletion was successful
        return (status == 200, nil)
    }
    
}
