//
//  AddRestroomViewController.swift
//  Releave
//
//  Created by Harrison Melton on 9/3/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import UIKit
import GoogleMaps

class AddRestroomViewController: MapViewController, GMSMapViewDelegate, CurrentLocationDelegate {
    
    private var locked = false
    private var rating = 0

    // When 'Cancel' button is pressed, dismiss the view controller
    @IBAction func onCancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onStarPressed(_ sender: UIButton) {
        // Get tag of selected star
        rating = sender.tag
        // Get filled an unfilled images for stars
        let filledStarImage = UIImage(named: "star_filled")
        let unfilledStarImage = UIImage(named: "star_unfilled")
        // Iterate over star buttons, giving each the appropriate image
        for button in starButtons {
            if button.tag <= rating {
                // Show star as filled
                button.setImage(filledStarImage, for: .normal)
            } else {
                // Show star as unfilled
                button.setImage(unfilledStarImage, for: .normal)
            }
        }
    }
    
    @IBAction func onCheckboxPressed(_ sender: UIButton) {
        // The sender's tag determines whether to display the checked or unchecked box
        let image = locked ?
            UIImage(named: "checkbox_checked")
            : UIImage(named: "checkbox_unchecked")
        
        sender.setImage(image, for: .normal)
        // Update global variable to reflect change in state
        locked = !locked
    }
    
    @IBAction func onSubmitPressed(_ sender: UIButton) {
        
    }
    
    @IBOutlet var starButtons: [UIButton]!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up GMSMapView
        setUpMap()
        
        self.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        // Round corners of info section
        roundInfoSectionCorners()
    }
    
    // This function sets up the GMSMapView
    private func setUpMap() {
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }
    
    // This function rounds the top corners of the info section.
    private func roundInfoSectionCorners() {
        // Declare which corners are to be rounded, and by how much
        let path = UIBezierPath(roundedRect: infoView.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        
        // Set path of mask layer
        maskLayer.path = path.cgPath
        // Round the corners
        infoView.layer.mask = maskLayer
    }
    
    // Update GMSMapView to reflect new location
    func didUpdateLocation(_ camera: GMSCameraPosition) {
        mapView.animate(to: camera)
    }
    
    // This function is called when the map becomes idle after moving
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("moved")
    }

}
