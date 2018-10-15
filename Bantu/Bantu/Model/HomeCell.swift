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
        
        eventImageView.setRounded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

