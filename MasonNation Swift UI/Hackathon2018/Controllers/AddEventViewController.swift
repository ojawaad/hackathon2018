//
//  AddEventViewController.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/13/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDescriptionTextField: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    var eventTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        eventTitleLabel.text = "Add \(eventTitle!)"
        
        mapView.alpha = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.showsCompass = true
        
        let center = CLLocationCoordinate2D(latitude: 38.83251032903352, longitude: -77.30786426501646)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func onShowHideMap(_ sender: Any) {
        if self.mapView.alpha == 0.0 {
            showMap()
        } else {
            hideMap()
        }
    }
    @IBAction func onSubmitEvent(_ sender: Any) {
        
    }
    
    fileprivate func hideMap() {
        UITextView.animate(withDuration: 0.3) {[unowned self] in
            self.mapView.alpha = 0.0
        }
    }
    
    fileprivate func showMap() {
        UITextView.animate(withDuration: 0.3) {[unowned self] in
            self.mapView.alpha = 1.0
        }
    }
    
}
