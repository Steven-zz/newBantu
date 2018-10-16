//
//  SubmissionDetailViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SubmissionDetailViewController: UIViewController {
    
    var currentPost: Post!
    let need: [String] = ["Buku", "Pencil","Baju"]
    
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolImageView: UIImageView!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var myMapView: MKMapView!
    
    @IBOutlet weak var needsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.setUpPost()
        self.setUpMap()
    }
    
    func setUpPost(){
        self.schoolNameLabel.text = self.currentPost.schoolName
        self.aboutTextView.text = self.currentPost.about
        self.accessTextView.text = self.currentPost.access
        self.addressTextView.text = self.currentPost.address
        self.notesTextView.text = self.currentPost.notes
    }
    
    func setUpMap() {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.currentPost.locationLatitude, self.currentPost.locationLongitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.myMapView.setRegion(region, animated: true)
        self.myMapView.showsUserLocation = true
    }
}

extension SubmissionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentPost.needs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NeedSubmissionCell
        cell.needSubmissionLabel.text = self.currentPost.needs[indexPath.row].needsName
        
        cell.needSubmissionLabel.layer.borderColor = UIColor.black.cgColor
        cell.needSubmissionLabel.layer.borderWidth = 1
        cell.needSubmissionLabel.layer.cornerRadius = 3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.needsCollectionView.frame.width/4-10, height: 20)
        
    }
    
    
}
