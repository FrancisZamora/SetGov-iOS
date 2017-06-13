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

class EventDetailViewController: SetGovTableViewController, EventAgendaCallback{
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
    var eventInfo = [Int: [String]]()
    var eventTitle = "Marine Advisory"
    var agendaInfo = [Int: String]()
    var Index = 0
    var selectedCity = " "
    var currentTime = " "
    var noAlert = false
    var videoRequested = false
    var timeArray = [String]()
    var eventTime = [String]()
  


    @IBOutlet var navTitle: UINavigationItem!
    
    
    
    func configureTime() -> String{
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month,from:date)
        let year = calendar.component(.year, from: date)
        
        
        let dateString = String(month) + "/" + String(day) + "/" + String(year) + " " + String(hour)
        
        timeArray.append(String(month) + "/" + String(day) + "/" + String("17"))
     
        timeArray.append(String(hour) + ":00")
        
        print (timeArray)
        
        return dateString
        
        
    }
    
    
    func compareTime() -> Bool {
        currentTime = self.configureTime()
        guard let array = eventInfo[indexofEvent] else {
            return false
        }
        eventTime.append((array[0]))
        
        eventTime.append((array[3]))
        
        print(eventTime[0])
        print(timeArray[0])
        print(timeArray[1])
        print(eventTime[1])
        print(timeArray[1]>eventTime[1])
        if (eventTime[0] == timeArray[0] && timeArray[1] >= eventTime[1]) {
            print("times are compatible")
            return true
        
        }
        
        else {
            print("times not compatible")
            return false
        }
        
        
        
        
        
    }

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EventDetailViewController")
        self.loadTitle()
        print(agendaInfo)
        
        print(self.compareTime())
        
        
        
    }
    
    func delayTransition() {
        print("transition to video being delayed")
    }
    
    func checkAlert() -> Bool {
        if videoRequested == true {
            return true
        }
        else {
            return false
            
        }
    }
    
    
    
        
        
        
        
        
    
    
    
    func loadTitle() {
        print("loading title")
        print(selectedEvents)
        print(eventList)
        print(indexofEvent)
        navTitle.title = eventList[indexofEvent]
        eventTitle = navTitle.title!
    }
    
    func loadAgendaDetail(data: Dictionary<Int,String>,index:Int) {
        
        
        
        
        print("EVENT AGENDA CALLBACK")
        print("LOADING AGENDA DETAIL HERE")
        agendaInfo = data
        print(agendaInfo)
        Index = index
        
        performSegue(withIdentifier: "showAgenda", sender: nil)
        
        print(data)
        print(data)
        
        
        
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
                agendaImage = eventStream.eventImage.image!
            
            if eventStream.firstpress == false {
                if noAlert == false {
                    let alert = UIAlertController(title: "Constant Stream Available", message: "Boston offers a 24/7 live stream", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Watch", style: .default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                    self.videoRequested = true
                        
                }))
                
                    alert.addAction(UIAlertAction(title: "No Thanks", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                    self.videoRequested = false
                        
                    }))

                    self.present(alert, animated: true, completion: nil)
                    noAlert = true
                    //present UI alert
                
                
                    // timer for three seconds
                    // present new cell git
                }
                
                
                
            }
            
            if compareTime() == true && eventStream.firstpress == false || checkAlert() == true {
                print(checkAlert())
                // only works when cell for row is refreshed 
                eventStream.nowLive()
                let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                        self.delayTransition()
                   
                }

                let eventLiveStream = tableView.dequeueReusableCell(withIdentifier: "EventLiveStream") as! EventLiveStream
                eventLiveStream.selectionStyle = .none
                print ("returning stream")
                eventLiveStream.configure()
                eventLiveStream.playVideo()
                    
                return eventLiveStream
                
                
                    

                                        //present event stream
                
            

            }
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
            print(eventInfo)
            print("stop")
            print(indexofEvent)
            guard let array = eventInfo[indexofEvent] else {
                return UITableViewCell()
                
            }
            infoCell.eventAddress.text = array[1]
            infoCell.eventTime.text = array[0]
            infoCell.eventHour.text = array[2]
            
            return infoCell
        }
        
        if(indexPath.row == 2) {
            let agendaCell = tableView.dequeueReusableCell(withIdentifier: "EventAgenda", for:indexPath) as! EventAgenda
            agendaCell.selectionStyle = .none
            agendaCell.agendaInfo = agendaInfo
            agendaCell.index = Index
            agendaCell.eventAgendaCallback = self
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
            discussionCell.disableEditing()
            return discussionCell
        }
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "EventStream", for:indexPath) as! EventStream
        return cell
        
    
        }
    
   
    
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showAgenda") {
            print("preparing view")
            print("view for agenda detail")
            let AgendaDetailViewController = segue.destination as! AgendaDetailViewController
            AgendaDetailViewController.agendaImage = agendaImage
            AgendaDetailViewController.eventTitle = eventTitle
            
            print(agendaInfo)
            
            AgendaDetailViewController.agendaInfo = agendaInfo
            print(AgendaDetailViewController.agendaInfo)
            AgendaDetailViewController.index = Index
        }
        
        
    }
    
    
    
    

    }

