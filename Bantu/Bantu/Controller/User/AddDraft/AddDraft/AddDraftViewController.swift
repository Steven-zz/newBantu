//
//  AddDraftViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class AddDraftViewController: UIViewController {
    
    
    //MARK: Outlet for textview & textfield
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var aboutTextField: UITextView!
    @IBOutlet weak var studentNoTextField: UITextField!
    @IBOutlet weak var teacherNo: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    //MARK: Outlet for collectionview
    @IBOutlet weak var needCollectionView: UICollectionView!
    @IBOutlet weak var schoolCollectionView: UICollectionView!
    @IBOutlet weak var roadCollectionView: UICollectionView!
    
    
    //MARK: Outlet for mapKit
    @IBOutlet weak var myMapView: MKMapView!
    
    
    //MARK: Outlet for scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: Variable Declaration
    var currentDraft = Post(postId: 0, userId: 0, statusId: 0, timeStamp: "", schoolName: "", about: "", studentNo: 0, teacherNo: 0, address: "", access: "", notes: "", locationAOI: "", locationName: "", locationLocality: "", locationAdminArea: "", locationLatitude: 0, locationLongitude: 0, schoolImages: [], roadImages: [], needs: [])
    
    var isNewDraft: Bool!
    var isPickingSchool: Bool = false
    var isPickingRoad: Bool = false
    var isCurrentlyEditing: Bool = false
    
    var locationManager = CLLocationManager()
    var locationUpdateCounter: Int = 0
    var tempLocLatitude: Double = 0
    var tempLocLongitude: Double = 0
    var tempLocAOI: String = ""
    var tempLocName: String = ""
    var tempLocLocality: String = ""
    var tempLocAdminArea: String = ""
    
    
    //MARK: Array Declaration
    var needs: [Needs] = [
        Needs(needsId: 1, needsName: "Air"),
        Needs(needsId: 2, needsName: "Buku")
    ]
    var selectedNeeds: [Bool] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
    }
    
    
    @objc func saveButtonTapped() {
        self.currentDraft.schoolName = self.schoolNameTextField.text!
        self.currentDraft.about = self.aboutTextField.text
        self.currentDraft.studentNo = Int(self.studentNoTextField.text!)!
        self.currentDraft.teacherNo = Int(self.teacherNo.text!)!
        self.currentDraft.access = self.accessTextView.text
        self.currentDraft.address = self.addressTextView.text
        self.currentDraft.notes = self.notesTextView.text
        
        self.currentDraft.locationLatitude = self.tempLocLatitude
        self.currentDraft.locationLongitude = self.tempLocLongitude
        self.currentDraft.locationAOI = self.tempLocAOI
        self.currentDraft.locationName = self.tempLocName
        self.currentDraft.locationLocality = self.tempLocLocality
        self.currentDraft.locationAdminArea = self.tempLocAdminArea
        
        self.isNewDraft = false
        self.saveNewDraftToCoreData()
    }
    
    
    @IBAction func hideKeyboard(_ sender: Any) {
        scrollView.endEditing(true)
    }
    
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addSchoolImageButtonTapped(_ sender: Any) {
        self.isPickingSchool = true
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func addRoadImageButtonTapped(_ sender: Any) {
        self.isPickingRoad = true
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: Save to Core Data
    func saveNewDraftToCoreData() {
        
        // Saving textview & textfield to core data
        let tempPost = DraftEntity(context: LocalServices.context)
        tempPost.schoolName = self.currentDraft.schoolName
        tempPost.aboutPost = self.currentDraft.about
        tempPost.studentNo = Int64(self.currentDraft.studentNo)
        tempPost.teacherNo = Int64(self.currentDraft.teacherNo)
        tempPost.accessPost = self.currentDraft.access
        tempPost.addressPost = self.currentDraft.address
        tempPost.notesPost = self.currentDraft.notes
        
        tempPost.locationLatitude = self.currentDraft.locationLatitude
        tempPost.locationLongitude = self.currentDraft.locationLongitude
        tempPost.locationAOI = self.currentDraft.locationAOI
        tempPost.locationName = self.currentDraft.locationName
        tempPost.locationLocality = self.currentDraft.locationLocality
        tempPost.locationAdminArea = self.currentDraft.locationAdminArea
        
        
        // Testing Print
        print(tempPost.schoolName!)
        print(tempPost.aboutPost!)
        print(tempPost.studentNo)
        print(tempPost.teacherNo)
        print(tempPost.accessPost!)
        print(tempPost.addressPost!)
        print(tempPost.notesPost!)
        print(tempPost.locationLatitude)
        print(tempPost.locationLongitude)
        print(tempPost.locationAOI!)
        print(tempPost.locationName!)
        print(tempPost.locationLocality!)
        print(tempPost.locationAdminArea!)
        
        
        // Saving image to core data
        var CDataArraySchool = NSMutableArray()
        var CDataArrayRoad = NSMutableArray()
        
        
        for img in self.currentDraft.schoolImages {
            let data: NSData = NSData(data: img.jpegData(compressionQuality: 1)!)
            CDataArraySchool.add(data)
        }
        
        
        for img in self.currentDraft.roadImages {
            let data: NSData = NSData(data: img.jpegData(compressionQuality: 1)!)
            CDataArrayRoad.add(data)
        }
        
        
        let coreDataObjectSchool = NSKeyedArchiver.archivedData(withRootObject: CDataArraySchool)
        let coreDataObjectRoad = NSKeyedArchiver.archivedData(withRootObject: CDataArrayRoad)
        
        tempPost.schoolImages = coreDataObjectSchool as NSData
        tempPost.roadImages = coreDataObjectRoad as NSData
        
        
        // Saving timestamp to core data
        let currDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-mm-yyyy"
        let dateString = formatter.string(from: currDate)
        let dateDate = formatter.date(from: dateString)
        
        print(dateDate!)
        
        tempPost.timeStamp = dateDate as! NSDate
        
        LocalServices.saveContext()
        
    }
    
    //MARK: Map Configuration
    func setUpMap() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func tapToShareLocation(_ sender: Any) {
        self.setUpMap()
    }
    
}


//MARK: Extension for collectionview
extension AddDraftViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.needCollectionView) {
            let cell = self.needCollectionView.dequeueReusableCell(withReuseIdentifier: "needCell", for: indexPath) as! NeedCollectionCell
            cell.myNeedsLabel.text = self.needs[indexPath.row].needsName
            cell.myNeedsLabel.backgroundColor = UIColor.gray
            return cell
        }
        else if (collectionView == self.schoolCollectionView) {
            let cell = self.schoolCollectionView.dequeueReusableCell(withReuseIdentifier: "schoolCell", for: indexPath) as! ImageCollectionCell
            cell.setImage(image: self.currentDraft.schoolImages[indexPath.row])
            return cell
        }
        
        let cell = self.roadCollectionView.dequeueReusableCell(withReuseIdentifier: "roadCell", for: indexPath) as! ImageCollectionCell
        cell.setImage(image: self.currentDraft.roadImages[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.needCollectionView) {
            print("Needs View")
            return self.needs.count
        }
        else if (collectionView == self.schoolCollectionView) {
            print("School View")
            return self.currentDraft.schoolImages.count
        }
        else {
            print("Road View")
            return self.currentDraft.roadImages.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var footerIdentifier: String = ""
        
        if (collectionView == self.schoolCollectionView) {
            footerIdentifier = "schoolFooter"
        }
        else if (collectionView == self.roadCollectionView) {
            footerIdentifier = "roadFooter"
        }
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath)
        return footerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.needCollectionView.frame.width/3-10, height: 30)
    }
    
}


//MARK: Extension for image picker
extension AddDraftViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            
            if (self.isPickingSchool == true) {
                self.isPickingSchool = false
                self.currentDraft.schoolImages.append(image)
                let indexPath = IndexPath(row: self.currentDraft.schoolImages.count-1, section: 0)
                self.schoolCollectionView.insertItems(at: [indexPath])
            }
            else {
                self.isPickingRoad = false
                self.currentDraft.roadImages.append(image)
                let indexPath = IndexPath(row: self.currentDraft.roadImages.count-1, section: 0)
                self.roadCollectionView.insertItems(at: [indexPath])
            }
        }
    }
    
}


//MARK: Extension for Map Kit
extension AddDraftViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        self.setLocationOnMap(userLocation: userLocation)
        
        self.tempLocLatitude = userLocation.coordinate.latitude
        self.tempLocLongitude = userLocation.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemark, error) in
            if self.locationUpdateCounter == 0
            {
                if (error != nil)
                {
                    // If Offline
                    print("You are Offline")
                }
                else
                {
                    // If Online
                    if let place = placemark?[0]
                    {
                        self.tempLocLocality = place.locality!
                        self.tempLocName = place.name!
                        self.tempLocAdminArea = place.administrativeArea!
                        self.tempLocAOI = place.areasOfInterest![0]
                    }
                    else
                    {
                        // Fail Pinpoint Location
                        print("Failed Pinpoint location")
                    }
                }
                self.locationUpdateCounter += 1
            }
            else
            {
                self.locationManager.stopUpdatingLocation()
                self.locationUpdateCounter = 0
            }
        }
        
    }
    
    
    func setLocationOnMap(userLocation: CLLocation) {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.myMapView.setRegion(region, animated: true)
        self.myMapView.showsUserLocation = true
    }
}

