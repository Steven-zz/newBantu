//
//  HomeViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    var events: [Event] = []
    var filteredEvents: [Event] = []
    
    var selectedIndex: Int = 0
    var searching = false
    
//    @IBAction func shareButtonTapped(_ sender: Any) {
//        let buttonPosition : CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
//        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
//        let sharedTitle = [eventTitles[(indexPath?.last)!]]
//
//        let activityController = UIActivityViewController(activityItems: sharedTitle, applicationActivities: nil)
//
//        self.present(activityController, animated: true, completion: nil)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        AddDraft.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.resultController.tableView.dataSource = self
        self.resultController.tableView.delegate = self
        
        self.setNeeds()
        self.getEvents()
    }
    
    func getEvents(){
        EventServices.getEvents(){ (events) in
            self.events = events
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
    
    func setNeeds(){
        let fetchRequest: NSFetchRequest<NeedsEntity> = NeedsEntity.fetchRequest()
        do{
            let fetchData = try LocalServices.context.fetch(fetchRequest)
            let tempResult = fetchData
            
            var tempNeeds: [Needs] = []
            
            // x as each row in entity
            for x in tempResult{
                let needsId = Int(x.needsId)
                let needsName: String = x.needsName!
                
                let newNeeds: Needs = Needs(needsId: needsId, needsName: needsName)
                
                tempNeeds.append(newNeeds)
            }
            print("fetch successful")
            AddDraft.needs = tempNeeds
            
        } catch {}
        
        NeedsServices.getNeeds { (needs) in
            if (needs.count != 0){
                for singleNeed in needs{
                    var found: Bool = false
                    for currNeed in AddDraft.needs{
                        if (singleNeed.needsId == currNeed.needsId){
                            found = true
                            break
                        }
                    }
                    if (found == false){
                        AddDraft.needs.append(singleNeed)
                        self.saveNeedsToCoreData(needs: singleNeed)
                    }
                }
            }
            print(AddDraft.needs)
        }
    }
    
    func saveNeedsToCoreData(needs: Needs){
        let tempNeeds = NeedsEntity(context: LocalServices.context)
        
        tempNeeds.needsId = Int64(needs.needsId)
        tempNeeds.needsName = needs.needsName
        
        LocalServices.saveContext()
    }
    
    var searchController: UISearchController!
    var resultController = UITableViewController()
    
    func setupNavBar() {
//        self.searchController = UISearchController(searchResultsController: self.resultController)
//        self.tableView.tableHeaderView = self.searchController.searchBar
//        self.searchController.searchResultsUpdater = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"user-4"), style: .plain, target: self, action: #selector(profileTapped))
    }
    
    @objc func profileTapped() {
        performSegue(withIdentifier: "homeToLog", sender: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == true {
            return self.filteredEvents.count
        } else {
            return self.events.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        if searching == true {
            cell.setCell(event: self.filteredEvents[indexPath.row])
        } else {
            cell.setCell(event: self.events[indexPath.row])
        }
        return cell
    }
    
}

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        search = event.filter({$0.title.lowercased().contains(searchText.lowercased())})
//        if searchText == ""{
//            search = event
//        }
//        searching = true
//        self.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        searchBar.text = ""
//        self.tableView.reloadData()
    }
}
