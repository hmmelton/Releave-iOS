//
//  Util.swift
//  Releave
//
//  Created by Harrison Melton on 9/6/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import UIKit

class Util {
    
    // This function displays an alert to the user
    static func displayAlert(title: String, message: String, viewController vc: UIViewController) {
        let alert = UIAlertController(title: "Incomplete Information", message: "All sections must be filled before a submission can be completed.", preferredStyle: UIAlertControllerStyle.alert)
        // Add 'OK' action
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // Present the alert
        vc.present(alert, animated: true, completion: nil)
    }
}
