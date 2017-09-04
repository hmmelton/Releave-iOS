//
//  ViewController.swift
//  Releave
//
//  Created by Harrison Melton on 9/2/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    // View
    @IBOutlet weak var mapView: GMSMapView!
    
    // Properties
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up GMSMapView
        setUpMap()
        
        // Find current location
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    // This function sets up the GMSMapView
    func setUpMap() {
        mapView.delegate = self
        // Settings
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Fetch most current location, or return if none is available
        guard let location = locations.last else {
            return
        }
        
        // Get coordinates of current location
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        // Display current location on map
        mapView.animate(to: camera)
        
        // Stop searching for location
        locationManager.stopUpdatingLocation()
    }
    
}

