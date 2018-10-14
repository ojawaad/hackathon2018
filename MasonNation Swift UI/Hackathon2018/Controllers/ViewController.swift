//
//  ViewController.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/13/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addEventView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var helloUser: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBAction func onGetCurrentLocation(_ sender: UIButton) {
        getUsersCurrentLocation()
    }
    @IBAction func onAddEventViewHide(_ sender: Any) {
        hideAddEventView()
    }
    
    @IBAction func onAddEventViewShow(_ sender: Any) {
        showAddEventView()
    }
    @IBAction func onMenuEnter(_ sender: Any) {
        showMenuView()
    }
    @IBAction func onMenuExit(_ sender: Any) {
        hideMenuView()
    }
    let locationManager = CLLocationManager()
    let annotations = MKPointAnnotation()
    var userLatitude: CLLocationDegrees?
    var userLongitude: CLLocationDegrees?
    var event = [EventMenu]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        getUsersCurrentLocation()
        
        event.append(EventMenu(img: UIImage(named: "efood.png")!, label: "Food", identifier: "FoodViewController"))
        event.append(EventMenu(img: UIImage(named: "ebus.png")!, label: "Bus", identifier: "BusViewController"))
        event.append(EventMenu(img: UIImage(named: "ehazard.png")!, label: "Hazard", identifier: "HazardViewController"))
        event.append(EventMenu(img: UIImage(named: "elove.png")!, label: "Love", identifier: "LoveViewController"))
        event.append(EventMenu(img: UIImage(named: "eparking.png")!, label: "Parking", identifier: "ParkingViewController"))
        event.append(EventMenu(img: UIImage(named: "eplay.png")!, label: "Play", identifier: "PlayViewController"))
        event.append(EventMenu(img: UIImage(named: "etraffic.png")!, label: "Traffic", identifier: "TrafficViewController"))
        
        self.addEventView.alpha = 0.0
        self.menuView.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon

        // Ask for authorization from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.showsCompass = true
        
        let center = CLLocationCoordinate2D(latitude: 38.83251032903352, longitude: -77.30786426501646)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        self.mapView.setRegion(region, animated: true)
//
//        // create a 3D Camera
//        let mapCamera = MKMapCamera()
//        mapCamera.centerCoordinate = CLLocationCoordinate2DMake(38.83251032903352, -77.30786426501646)
//        mapCamera.pitch = 45
//        mapCamera.altitude = 500 // example altitude
//        mapCamera.heading = 45
//
//        // set the camera property
//        mapView.camera = mapCamera
//
    }
    
    func getUsersCurrentLocation() {
        if let userLatitude = userLatitude, let userLongitude = userLongitude {
            let center = CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        
        print("user latitude = \(location.coordinate.latitude)")
        print("user longitude = \(location.coordinate.longitude)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return event.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCollection", for: indexPath) as! EventCollectionViewCell
        
        let event = self.event[indexPath.row]
        cell.setMenu(img: event.img, name: event.label)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.event[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addEvent") as! AddEventViewController
        
        vc.eventTitle = event.label

        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func hideAddEventView() {
        UITextView.animate(withDuration: 0.3) {[unowned self] in
            self.addEventView.alpha = 0.0
        }
    }
    
    fileprivate func showAddEventView() {
        UITextView.animate(withDuration: 0.3) {[unowned self] in
            self.addEventView.alpha = 1.0
        }
    }

    fileprivate func hideMenuView() {
        UITextView.animate(withDuration: 0.3) {[unowned self] in
            self.menuView.alpha = 0.0
        }
    }
    
    fileprivate func showMenuView() {
        UITextView.animate(withDuration: 0.3) {[unowned self] in
            self.menuView.alpha = 1.0
        }
    }

    // Unwinds
    @IBAction func unwindWithoutAction(sender: UIStoryboardSegue) {
    }
    @IBAction func unwindFromAddEvent(sender: UIStoryboardSegue) {
//        alertUser("Thank You!", msg: "Your submission has been posted.")
        hideAddEventView()
        
        if let sourceViewController = sender.source as? AddEventViewController, let savedAnnotation = sourceViewController.savedAnnotation {
            mapView.addAnnotation(savedAnnotation)
        }
    }
    
    @IBAction func unwindFromLogin(sender: UIStoryboardSegue) {
        //        alertUser("Thank You!", msg: "Your submission has been posted.")
        hideAddEventView()
        helloUser.text = "Hello Jc!"
        
    }
    
    @IBAction func unwindFromInvite(sender: UIStoryboardSegue) {
        //        alertUser("Thank You!", msg: "Your submission has been posted.")
        hideAddEventView()
    }
    
    @IBAction func unwindFromFilter(sender: UIStoryboardSegue) {
        //        alertUser("Thank You!", msg: "Your submission has been posted.")
        hideAddEventView()
    }

}

class EventMenu {
    
    //MARK: Properties
    
    var img: UIImage
    var label: String
    var identifier: String
    
    //MARK: Initialization
    
    init(img: UIImage, label: String, identifier: String) {
        
        // Initialize stored properties.
        self.img = img
        self.label = label
        self.identifier = identifier
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alertUser(_ title: String, msg: String?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
//
//    func createSpinner() -> NVActivityIndicatorView {
//        let spinner = NVActivityIndicatorView(frame: CGRect(x: (self.view.frame.width / 2) - 50, y: (self.view.frame.height / 2) - 50, width: 100, height: 100), type: NVActivityIndicatorType(rawValue: 12))
//        spinner.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 51/255, alpha: 1.0)
//        spinner.padding = 20;
//        spinner.layer.cornerRadius = 10
//        self.view.addSubview(spinner)
//        spinner.startAnimating()
//        return spinner
//    }
//
//    func destroySpinner(_ spinner: NVActivityIndicatorView) {
//        spinner.stopAnimating()
//        spinner.removeFromSuperview()
//    }
    
    // Dates
    func convertDateFrom(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: string) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        return date
    }
    
    func converSQLStringFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func convertStringFrom(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
}
