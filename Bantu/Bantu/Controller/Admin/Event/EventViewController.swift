//
//  EventViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addEventTapped(_ sender: Any) {
        performSegue(withIdentifier: "eventToAddEvent", sender: self)
    }
    

}
