//
//  HomeCell.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(event: Event){
        self.eventImageView.image = event.img
        self.eventTitleLabel.text = event.eventName
        
        let startDateResult = event.startDate.replacingOccurrences(of: "-", with: "/")
        let endDateResult = event.endDate.replacingOccurrences(of: "-", with: "/")
        self.dateLabel.text = "\(startDateResult) - \(endDateResult)"
        self.locationLabel.text = ""
    }
}

