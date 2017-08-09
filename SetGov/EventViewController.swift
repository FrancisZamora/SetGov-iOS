//
//  EventViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 3/6/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import SwiftyJSON
import Kanna

class EventViewController: SetGovTableViewController{
    var activate = true
    var selectedCity = "Fort Lauderdale"
    var count = 0
    var numsections = 0
    var spacer = "  "
    var eventTitle = "Marine Advisory"
    var eventTitles = [String]()
    var indexofEvent = 0
    var counter = -1
    var eventImage = #imageLiteral(resourceName: "Image1")
    var time = "9:00pm"
    var eventArray = [String]()
    var firstVisited = [Bool]()
    var eventList = [Int:String]()
    var eventImages = [Int:UIImage]()
    var eventInfo = [Int: [String]]()
    var titleEvents = [Int: String]()
    var arrayEvents = [String]()

    var fortlauderdaleArray = [[String]()]
    var dateArray = [Date]()
    var user: User!
    var picArray = [[String]()]
    var bostonDataList = [Event]()
    var fortlauderdaleDataList = [Event]()
    
    
    
    
    @IBOutlet var cityDisplay: UINavigationItem!
    
    func isEven (num:Int) -> Bool {
        if num % 2 == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    
    func checkMembers() {
//        ApiClient.fetchEvents(city: selectedCity,  onCompletion: { event in
//            switch self.selectedCity {
//            case "Boston":
//                self.bostonDataList = event
//            case "Fort Lauderdale":
//                self.fortlauderdaleDataList = event
//            default:
//                self.bostonDataList = event
//                
//                
//            }
//            self.tableView.reloadData()
//        
//        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedCity)
        self.bostonDataList = self.appDelegate.bostonDataList
        self.fortlauderdaleDataList = self.appDelegate.fortlauderdaleDataList
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CityNavigationViewController") as! CityNavigationViewController
        self.navigationController?.viewControllers.insert(controller, at: 1)

        self.user = self.appDelegate.user

        print(self.user.fullName)
        
               self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
        print("EventViewController")
        self.setCity()
        print(selectedCity)

        if UserDefaults.standard.integer(forKey: "eventoverLay") != 1 {

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                     self.performSegue(withIdentifier: "overLay", sender: nil)
            
            }
        }
        UserDefaults.standard.set(1,forKey:"eventoverLay")
        
        print(UserDefaults.standard.integer(forKey: "eventoverLay"))
        
        
    }
    
    func getDataList() -> [Event] {
        switch selectedCity {
        case "Boston":
            return bostonDataList
        case "Fort Lauderdale":
            return fortlauderdaleDataList
        default:
            return bostonDataList
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.checkMembers()
    }

    

    
    
    func setCity() {
        if selectedCity == "Fort Lauderdale" {
            cityDisplay.title = "Fort Lauderdale, FL "
            
        }
        
        if selectedCity == "Boston" {
            cityDisplay.title = "Boston, MA "
        }
        
        if selectedCity == "New York City" {
            cityDisplay.title = "New York, NY "
        }
        
    }
    
    //tableview methods
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.numsections = 1
        print("numberofSections")
        return 3
    }
    
    func appendOnce() -> Int {
        counter += 1
        print("THIS IS THE COUNTER")
        print(counter)
        return counter
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if selectedCity == "Boston" {
            return bostonDataList.count

        }
        
        
        if selectedCity == "Fort Lauderdale" {
            return fortlauderdaleDataList.count
        }
            
        
        else {
            return 0
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if picArray.count <= 1 || picArray.isEmpty == true  {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
            cell.configure()
            cell.selectionStyle = .none
            cell.selectedCity = selectedCity
            var x = getDataList()
            cell.editCell(Event: x[indexPath.row])
            cell.selectionStyle = .none
            print(" we hit the conditional")
            return cell

            
        }
        
        if selectedCity == "Boston" {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
            cell.selectedCity = selectedCity
            cell.selectionStyle = .none
            var x = getDataList()
            cell.editCell(Event:x[indexPath.row])
           

            //cell.alpha = 0.50
            print("this is the picture array length\(picArray.count)")
            print(picArray)
            print(indexPath.row)
            cell.picArray = picArray[indexPath.row]
            let counter = cell.picArray.count
            cell.memberCount.text = String(describing: counter)
            cell.usersCollection.reloadData()

           // UIView.animate(withDuration: 0.88) {
              //  cell.alpha = 1
          //  }
            
            eventImage = cell.eventImage.image!
            eventImages.updateValue(eventImage, forKey: indexPath.row)
            
            return cell
        }
         if selectedCity == "Fort Lauderdale" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            cell.selectionStyle = .none
            var x = getDataList()
            cell.editCell(Event:x[indexPath.row])
           // cell.alpha = 0
            
            cell.picArray = picArray[indexPath.row]
            let counter = cell.picArray.count
            cell.memberCount.text = String(describing: counter)
            cell.usersCollection.reloadData()
            cell.usersCollection.reloadData()
          //  UIView.animate(withDuration: 1.0) {
              //  cell.alpha = 1
          //  }
            
            eventImage = cell.eventImage.image!
            eventImages.updateValue(eventImage,forKey: indexPath.row)
            
            return cell
       }
        
       let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
       cell.configure()
       cell.selectionStyle = .none
        
       return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        if selectedCity == "Fort Lauderdale" {
            
            indexofEvent = indexPath.row
            performSegue(withIdentifier: "showEvent", sender: nil)
            
        }
        
        
        if selectedCity == "Boston" {
            indexofEvent = indexPath.row
            performSegue(withIdentifier: "showEvent", sender: nil)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEvent") {
            
            let EventDetailViewController = segue.destination as! EventDetailViewController
            EventDetailViewController.selectedEvents = eventTitles
            EventDetailViewController.indexofEvent = indexofEvent
            EventDetailViewController.eventList = eventList
            EventDetailViewController.eventImages = eventImages
            EventDetailViewController.selectedCity = selectedCity
            EventDetailViewController.fortlauderdaleDataList = fortlauderdaleDataList
            EventDetailViewController.bostonDataList = bostonDataList 
        }
    }
}
