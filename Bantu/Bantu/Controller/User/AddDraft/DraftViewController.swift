//
//  DraftViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class DraftViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dates = ["10/11/2018", "10/12/2018"]
    var schoolNames = ["SDN 1 Gading Serpong", "SDN 222 Jakarta"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AddDraft.selectedIndex = 2
    }
}

extension DraftViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let draftCell = self.tableView.dequeueReusableCell(withIdentifier: "draftCell", for: indexPath) as! DraftCell
        
        draftCell.dateLabel.text = dates[indexPath.row]
        draftCell.schoolNameLabel.text = schoolNames[indexPath.row]
        draftCell.accessoryType = .disclosureIndicator
        
        return draftCell
    }
    
    
}
