//
//  AddRestroomViewController.swift
//  Releave
//
//  Created by Harrison Melton on 9/3/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import UIKit
import GoogleMaps

class AddRestroomViewController: UIViewController {

    // When 'Cancel' button is pressed, dismiss the view controller
    @IBAction func onCancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
