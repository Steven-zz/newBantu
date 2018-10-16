//
//  SubmissionViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class SubmissionViewController: UIViewController {
    
    @IBOutlet weak var submissionsTable: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getSubmissions()
    }
    
    
    func getSubmissions(){
        PostServices.getPosts(){ (tempPosts) in
            self.posts = tempPosts
            DispatchQueue.main.async {
                self.submissionsTable.reloadData()
            }
        }
    }
}


extension SubmissionViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! postCell
        cell.setCell(post: self.posts[indexPath.row])
        return cell
    }
    
    
}


