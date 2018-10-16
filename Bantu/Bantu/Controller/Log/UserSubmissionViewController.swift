//
//  UserSubmissionViewController.swift
//  Bantu
//
//  Created by Steven Muliamin on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class UserSubmissionViewController: UIViewController {
    
    @IBOutlet weak var userSubmissionTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension UserSubmissionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalSession.submissions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userSubmissionCell") as! userSubmissionCell
        cell.setCell(post: GlobalSession.submissions[indexPath.row])
        return cell
    }
    
    
}
