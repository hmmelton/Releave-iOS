//
//  MapViewController.swift
//  Releave
//
//  Created by Harrison Melton on 9/3/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    // Properties
    var locationManager = CLLocationManager()
    var delegate: CurrentLocationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Find current location
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Fetch most current location, or return if none is available
        guard let location = locations.last else {
            return
        }
        
        // Get coordinates of current location
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        
        // Stop searching for location
        locationManager.stopUpdatingLocation()
        
        // Send new location back to delegate
        delegate?.didUpdateLocation(camera)
    }
}

protocol CurrentLocationDelegate {
    func didUpdateLocation(_ camera: GMSCameraPosition)
}
