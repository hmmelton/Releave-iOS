//
//  LoginViewController.swift
//  Releave
//
//  Created by Harrison Melton on 9/6/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBAction func fbLoginPressed(_ sender: UIButton) {
        let loginManager = LoginManager()
        // Login with Facebook
        loginManager.logIn([.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("Login cancelled")
            case .success( _, _, let accessToken):
                // Login was successful - 
                self.getFbUserInfo(accessToken)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // This function retrieves the current user's info from Facebook.
    private func getFbUserInfo(_ accessToken: AccessToken) {
        let connection = GraphRequestConnection()
        // Define the request to be made to Facebook
        let request = GraphRequest(graphPath: "/me", parameters: ["fields": "id, first_name, last_name, email"], accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion)
        
        // Add GraphRequest to the connection
        connection.add(request) { (httpResponse, result) in
            switch result {
            case .success(let response):
                // Request was successful
                // Print response
                guard let dictionaryValue = response.dictionaryValue else {
                    print("No dictionary value was returned")
                    return
                }
                
                let facebookId = dictionaryValue["id"] as! String
                print("\n\n\(facebookId)\n\n")
                
                // Navigate to main page
                self.performSegue(withIdentifier: "loginToMain", sender: self)
            case .failed(let error):
                // Request failed - print error
                print("\n\nGraph request failed: \(error)\n\n")
            }
        }
        // Start request
        connection.start()
    }

}
