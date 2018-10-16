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
    
    var months: [String] = [
        "Januari", "Februari", "Maret", "April", "May", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(event: Event){
        self.eventImageView.image = event.img
        self.eventTitleLabel.text = event.eventName
        self.dateLabel.text = "\(event.startDate.beautifyDate()) - \(event.endDate.beautifyDate())"
        self.locationLabel.text = ""
    }
}

