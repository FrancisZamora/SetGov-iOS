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
    var selectedEvent = Event()
    
    
    
    
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
    
    func getTime(time:String) -> String {
        var temp = time.components(separatedBy: ":")
        if Int(temp[0])! < 7 || Int(temp[0])! == 12 {
            let newTime = temp [0] + ":" + temp[1] + "pm"
            return newTime
        }
        else {
            let newTime = temp[0] + ":" + temp[1] + "am"
            return newTime
        }
    }
    
    
    
    func getImage(int:Int ) -> UIImage {
        if selectedCity == "Boston" {
                if  bostonDataList[int].address == "1 City Hall Square" || bostonDataList[int].address == "1 City Hall Plaza" {
                return #imageLiteral(resourceName: "Image-12")
            }
            if bostonDataList[int].address == "Boston City Hall" {
                bostonDataList[int].address = "1 City Hall Square"
                return #imageLiteral(resourceName: "Image-12")
            }
            if bostonDataList[int].address == "26 Court Street"{
                return #imageLiteral(resourceName: "Image-13")
            }
            else {
                return #imageLiteral(resourceName: "brownstone")
            }
           
        }
        if selectedCity == "Fort Lauderdale" {
          
            return #imageLiteral(resourceName: "Image-7")
        }
        
      
        return #imageLiteral(resourceName: "Image")
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
        ApiClient.fetchEvents(city: selectedCity, onCompletion: { events in
            switch self.selectedCity {
                case "Boston":
                    self.bostonDataList = events
                    break
                case "Fort Lauderdale":
                    self.fortlauderdaleDataList = events
                    break
                default:
                    break
            }
            self.tableView.reloadData()
        })
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
        var data = getDataList()
        let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        cell.event = data[indexPath.row]
        cell.event.time = getTime(time: cell.event.time)
        cell.event.image = getImage(int: indexPath.row)
        cell.configure(event: data[indexPath.row])
        print(" we hit the conditional")
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        if selectedCity == "Fort Lauderdale" {
            
            selectedEvent = fortlauderdaleDataList[indexPath.row]
            indexofEvent = indexPath.row
            performSegue(withIdentifier: "showEvent", sender: nil)
            
        }
        
        
        if selectedCity == "Boston" {
            selectedEvent = bostonDataList[indexPath.row]
            indexofEvent = indexPath.row
            performSegue(withIdentifier: "showEvent", sender: nil)
        }
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEvent") {
            
            let eventDetailViewController = segue.destination as! EventDetailViewController
            eventDetailViewController.selectedEvents = eventTitles
            eventDetailViewController.indexofEvent = indexofEvent
            eventDetailViewController.eventList = eventList
            eventDetailViewController.currentEvent = selectedEvent
            eventDetailViewController.selectedCity = selectedCity
            eventDetailViewController.fortlauderdaleDataList = fortlauderdaleDataList
            eventDetailViewController.bostonDataList = bostonDataList
        }
    }
}
