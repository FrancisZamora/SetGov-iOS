//
//  EventDetailViewController.swift
//  
//
//  Created by Francis Zamora on 3/22/17.
//
//

import Foundation
import UIKit
import QuartzCore

class EventDetailViewController: SetGovTableViewController{
    var activate = true
    var infoCell = true
    var memberCell = true
    var count = 0
    var numsections = 0
    var animateView: Bool = false
    var counter = 0
    var selectedEvent = ""
    var selectedEvents = [String]()
    var indexofEvent = 0
    var eventList = [Int:String]()
    var eventImages = [Int: UIImage]()
    var agendaImage = #imageLiteral(resourceName: "Image1")
    @IBOutlet var navTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EventDetailViewController")
        self.loadTitle()
        
    }
    
    func loadTitle() {
        print("loading title")
        print(selectedEvents)
        print(eventList)
        print(indexofEvent)
        navTitle.title = eventList[indexofEvent]
    }
    
      override func viewDidAppear(_ animated: Bool) {
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.numsections = 1
        print("numberofSections")
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberofRows")
        return 6
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 38
        case 2:
            return 176
        case 3:
            return 94
        case 4:
            return 280
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        if (indexPath.row == 0) {
            let eventStream =  tableView.dequeueReusableCell(withIdentifier: "EventStream") as! EventStream
                eventStream.selectionStyle = .none
        
          
           
                eventStream.configure()
                eventStream.streamContent()
                eventStream.eventImage.image = eventImages[indexofEvent]
                eventStream.secondaryEventImage.image = eventImages[indexofEvent]
                agendaImage = eventStream.eventImage.image
            if eventStream.initiateStream == false {
                return eventStream
            }
            if (animateView == true) {
                print("reloading data")
                eventStream.activateStream() 
                self.tableView.reloadData()
            }
            
            if eventStream.initiateStream == true {
                // add transition with 2 second delay coming in from the right 
                print(eventStream.presentStream)
                let eventLiveStream = tableView.dequeueReusableCell(withIdentifier: "EventLiveStream") as! EventLiveStream
                eventLiveStream.selectionStyle = .none
                print ("returning stream")
                eventLiveStream.configure()
                eventLiveStream.playVideo()
               
                return eventLiveStream

            }
            print("cell for row" )

            
            return eventStream
            
            
            
        }
        
        if(indexPath.row == 1) {
            let infoCell =  tableView.dequeueReusableCell(withIdentifier: "EventInfo", for:indexPath) as! EventInfo
            infoCell.selectionStyle = .none

            return infoCell
        }
        
        if(indexPath.row == 2) {
            let agendaCell = tableView.dequeueReusableCell(withIdentifier: "EventAgenda", for:indexPath) as! EventAgenda
            agendaCell.selectionStyle = .none
            
            return agendaCell
        }
        
        if (indexPath.row==3) {
            let newCell = tableView.dequeueReusableCell(withIdentifier: "EventMembers", for:indexPath) as! EventMembers
            newCell.selectionStyle = .none
            return newCell
        }
        
        if (indexPath.row==4) {
            let discussionCell = tableView.dequeueReusableCell(withIdentifier: "EventDiscussion", for:indexPath) as! EventDiscussion
            discussionCell.selectionStyle = .none
            return discussionCell
        }
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "EventStream", for:indexPath) as! EventStream
        return cell
        
    
        }
    }

