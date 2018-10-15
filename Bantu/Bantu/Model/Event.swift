//
//  Event.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var image: UIImage
    var title: String
    var date: String
    var location: String
    
    init(image: UIImage, title: String, date: String, location: String) {
        self.image = image
        self.title = title
        self.date = date
        self.location = location
        
    }
    
}
