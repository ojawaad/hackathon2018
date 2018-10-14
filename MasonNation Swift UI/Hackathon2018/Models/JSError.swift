//
//  JSError.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/14/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import Foundation

struct JSError : Codable {
    let errorMessage: String?
    
    private enum CodingKeys: String, CodingKey {
        case errorMessage = "error_message"
    }
}
