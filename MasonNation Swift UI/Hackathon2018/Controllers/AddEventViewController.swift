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

class AddEventViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDescriptionTextField: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    var eventTitle: String!
    var image: UIImage!
    var currentAnnotation: CustomAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        eventTitleLabel.text = "Add \(eventTitle!)"
        
        mapView.alpha = 0.0
        
        // Add long press gesture
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action:(#selector(setAnnotation)))
        gestureRecognizer.minimumPressDuration = 1.0
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
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
        self.performSegue(withIdentifier: "unwindFromAddEvent", sender: self)
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
    
    @objc func setAnnotation(gestureRecognizer: UILongPressGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = CustomAnnotation(title: eventDescriptionTextField.text!, image: image, lat: newCoordinates.latitude, long: newCoordinates.longitude)
        if let currentAnnotation = currentAnnotation {
            mapView.removeAnnotation(currentAnnotation)
        }
        mapView.addAnnotation(annotation)
        currentAnnotation = annotation
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? CustomAnnotation {
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier){
                return view
            } else {
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
                view.image = annotation.image
                view.isEnabled = true
                view.canShowCallout = true
                view.leftCalloutAccessoryView = UIImageView(image: annotation.image)
                return view
            }
        }
        
        return nil
    }
    
}
