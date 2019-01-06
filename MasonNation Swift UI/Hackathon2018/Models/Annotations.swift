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
    var image: UIImage!
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    init                                                                                                                                          (title: String, subtitle: String, image: UIImage, lat: CLLocationDegrees, long: CLLocationDegrees){
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.coordinate = CLLocationCoordinate2DMake(lat, long)
    }
}
