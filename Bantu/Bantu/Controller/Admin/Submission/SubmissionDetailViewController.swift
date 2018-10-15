//
//  SubmissionDetailViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class SubmissionDetailViewController: UIViewController {
    
     let need: [String] = ["Buku", "Pencil","Baju"]
    
    
    @IBOutlet weak var schoolImageView: UIImageView!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SubmissionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return need.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NeedSubmissionCell
        cell.needSubmissionLabel.text = need[indexPath.row]
        return cell
    }
    
    
}
