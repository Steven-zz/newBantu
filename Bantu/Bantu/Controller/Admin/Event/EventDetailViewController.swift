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
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var joinButton: UIButton!
    
    var currentEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.joinButton.buttonDesign()

       
        self.setUp()
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "eventDetailToRegister", sender: self)
    }
    func setUp(){
        self.eventImg.image = self.currentEvent.img
        self.eventNameLabel.text = self.currentEvent.eventName
        self.timeLabel.text = "\(self.currentEvent.startDate.beautifyDate()) - \(self.currentEvent.endDate.beautifyDate())"
        self.locationLabel.text = "\(self.currentEvent.locationLocality), \(self.currentEvent.locationAdminArea)"
        self.feeLabel.text = "Rp. \(self.currentEvent.fee)"
        self.descriptionTextView.text = self.currentEvent.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EventDetailToEventDetailMore"){
            let destination = segue.destination as! EventDetailMoreViewController
            destination.currentEvent = self.currentEvent
        }
    }

    @IBAction func seeMoreButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "EventDetailToEventDetailMore", sender: self)
    }
}
