//
//  EventCollectionViewCell.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/13/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    func setMenu(img: UIImage, name: String) {
        imageView.image = img
        labelView.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
