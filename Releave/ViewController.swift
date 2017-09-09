//
//  ViewController.swift
//  Releave
//
//  Created by Harrison Melton on 9/2/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import UIKit
import GoogleMaps
import FacebookCore
import FacebookLogin

class ViewController: MapViewController, GMSMapViewDelegate, CurrentLocationDelegate {
    
    // View
    @IBOutlet weak var mapView: GMSMapView!
    // FIXME: This should not log out the user
    @IBAction func onSettingsPressed(_ sender: UIBarButtonItem) {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up GMSMapView
        setUpMap()
                
        self.delegate = self
    }
    
    // This function sets up the GMSMapView
    func setUpMap() {
        mapView.delegate = self
        // Settings
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.rotateGestures = true
    }
    
    // Update GMSMapView to reflect new location
    func didUpdateLocation(_ camera: GMSCameraPosition) {
        mapView.animate(to: camera)
    }
    
}

