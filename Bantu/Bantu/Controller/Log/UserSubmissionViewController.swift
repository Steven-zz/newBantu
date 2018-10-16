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
    
    var submissions: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getSubmissions()
    }
    
    func getSubmissions(){
        PostServices.getPostsByUser(){ (submissions) in
            self.submissions = submissions
            DispatchQueue.main.async {
                self.userSubmissionTableView.reloadData()
            }
        }
    }

}

extension UserSubmissionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.submissions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userSubmissionCell") as! userSubmissionCell
        cell.setCell(post: self.submissions[indexPath.row])
        return cell
    }
    
    
}
