//
//  Annotations.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/14/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let image: UIImage!
    let identifier = "customAnnotation"
    var title: String?
    var coordinate: CLLocationCoordinate2D
    init(title: String, image: UIImage, lat: CLLocationDegrees, long: CLLocationDegrees){
        self.image = image
        self.title = title
        self.coordinate = CLLocationCoordinate2DMake(lat, long)
    }
}
