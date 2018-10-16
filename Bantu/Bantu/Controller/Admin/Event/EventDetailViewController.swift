//
//  EventDetailViewController.swift
//  Bantu
//
//  Created by Steven Muliamin on 17/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var eventImg: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    var currentEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    func setUp(){
        self.eventImg.image = self.currentEvent.img
        self.eventNameLabel.text = self.currentEvent.eventName
        self.timeLabel.text = "\(self.currentEvent.startDate.beautifyDate()) - \(self.currentEvent.endDate.beautifyDate())"
        self.locationLabel.text = "\(self.currentEvent.locationLocality), \(self.currentEvent.locationAdminArea)"
        self.feeLabel.text = "Rp. \(self.currentEvent.fee)"
        self.aboutLabel.text = self.currentEvent.description
    }

}
