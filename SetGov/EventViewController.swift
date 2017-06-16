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
    var address = "100 North Andrews Avenue"
    var time = "9:00pm"
    var eventArray = [String]()
    var firstVisited = [Bool]()
    var eventList = [Int:String]()
    var eventImages = [Int:UIImage]()
    var eventInfo = [Int: [String]]()
    var titleEvents = [Int: String]()
    var arrayEvents = [String]()
    var infoEvents = [Int:[String]]()
    var firstTime = true
    var dataList = [Event]()
    var html = " "
    var numIterations = 0
    var eventTimes = [String]()
    var eventDescriptions = [String]()
    var descriptionArray = [String]()
    
    
    
    @IBOutlet var cityDisplay: UINavigationItem!

    func parseHTML(html:String) -> Void {
        print("parse fort lauderdale successfully called")
        if selectedCity == "Boston" {
            let url = URL(string: "https://www.boston.gov/public-notices")
            print(url as Any)
            print("continue")
        
            guard let doc = HTML(url: url!, encoding: .utf8) else  {
                return
            }
            print(doc.title as Any)
            print(doc.body as Any)
        
            print("continue")
        
            for notices in doc.css("a[href*='/public-notices/2']") {
                
                let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print("\(showString)\n")
                titleEvents.updateValue(showString, forKey: numIterations)
                numIterations = numIterations + 1
                print(titleEvents)
                let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
                
                if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                    
                    print("\(showString)\n")
                    print("string was printed once")
                }
                arrayEvents.append(showString)
                
            }
                for notices in doc.css(".date-display-single") {
                    numIterations = 0
                   
                    let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    print("\(showString)\n")
                    var newArray = showString.components(separatedBy: ",")
                    var newString = newArray[0]
                    eventTimes.append(newString)
                    let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
                    
                    if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                        //shows.add(showString)
                        
                        print("\(showString)\n")
                        print("string was printed twice")
                        
                    }
                }
                print(infoEvents)
            
            }
            print(arrayEvents)
           // print(eventTimes)
        
            if selectedCity == "Fort Lauderdale" {
                let url = URL(string: "https://fortlauderdale.legistar.com/Calendar.aspx")
                print(url as Any)
                print("continue")
                
                guard let doc = HTML(url: url!, encoding: .utf8) else  {
                    return
                }
                print(doc.title as Any)
                print(doc.body as Any)
                
                print("continue")
                
                for notices in doc.css("a[href*='MeetingDetail.aspx?']") {
                    
                    let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    print("\(showString)\n")
                    titleEvents.updateValue(showString, forKey: numIterations)
                    numIterations = numIterations + 1
                    print(titleEvents)
                    let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
                    
                    if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                        
                        print("\(showString)\n")
                        print("string was printed once")
                    }
                    arrayEvents.append(showString)
                    
                }
                for notices in doc.css(".date-display-single") {
                    numIterations = 0
                    
                    let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    print("\(showString)\n")
                    var newArray = showString.components(separatedBy: ",")
                    var newString = newArray[0]
                    eventTimes.append(newString)
                    let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
                    
                    if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                        //shows.add(showString)
                        
                        print("\(showString)\n")
                        print("string was printed twice")
                        
                    }
                    
                }
                print(infoEvents)

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            }
        }
    
    
    func splitEventDescription() {
        var x = 0
        for (_) in eventDescriptions {
            var eventDescriptions = arrayEvents[0].components(separatedBy: " ")
            print(eventDescriptions)
            print(eventDescriptions)
            print("what just printed")
           // print(arrayEvents)
            
            print("EVENT DESCRIPTIONS")
            var lastIndex = eventDescriptions.count
            descriptionArray.append(eventDescriptions[lastIndex])
            print(x)
            x = x + 1
            if x > count {
                return
            }


            
        }
        
      //  print(descriptionArray)
        
        
        
        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        print("EventViewController")
        self.setCity()
        print(selectedCity)
        self.fetchEventData()
        self.parseHTML(html: "swag")
        self.splitEventDescription()
 
    }
    
    func fetchEventData() {
        
        if selectedCity == "Boston" {
            
            
            let event = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
      
        
            dataList.append(event)
        
            let event2 = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
        
            dataList.append(event2)
        
            let event3 = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
        
            dataList.append(event3)
        
            let event4 = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
        
            dataList.append(event4)
        
                let event5 = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
            dataList.append(event5)
    
        }
        
        
        if selectedCity == "Miami" {
            
            
            let event = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
            
            
            dataList.append(event)
            
            let event2 = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
            
            dataList.append(event2)
            
            let event3 = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
            
            dataList.append(event3)
            
            let event4 = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
            
            dataList.append(event4)
            
            let event5 = Event (eventTitle: "Parks and Recreation", eventDescription: "Quarterly meeting", eventDate: "June 3rd", eventImageName: "fortlauderdalepark", eventTags: ["natural","legislation"])
            
            dataList.append(event5)
            
        }
        
    }
        

    
    
    
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setCity() {
        if selectedCity == "Fort Lauderdale" {
           cityDisplay.title = "Fort Lauderdale, FL "
            
        }
        if selectedCity == "Boston"
        {
            cityDisplay.title = "Boston, MA "
            
        }
        if selectedCity == "New York City" {
            cityDisplay.title = "New York, NY "
        }

    }
    
   

    
    
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
        print("numberofRows")
        return 4
        
    }
    
   

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        //new cell for row refactor
        //cell = dataList[indexPath.row]
        //hashtagOne = dataList[indexPath.row][eventTag[0]]
        //hashtagTwo = dataList[indexPath.row][eventTag[1]]
        //
        if selectedCity == "Fort Lauderdale" {
            if indexPath.row == 0 {
                print("CELL IS ONE")
                let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                cell.hashtagOne.text = "environmental"
                cell.hashtagTwo.text = "committee"
                cell.eventOriginalTitle = "City Council"
                cell.eventTitle.text = spacer + cell.eventOriginalTitle
                cell.eventDescription.text = "Bi-Monthly meeting"
                cell.eventDate.text = "May 29th"
                cell.eventImage.image = #imageLiteral(resourceName: "Image-7")
                if firstTime == true {
                    cell.configure()
                }
                eventArray.append("5/29/17")
                eventArray.append(address)
                print("eventTitle")
                print(eventTitle)
                print("TESTING")
                print(cell.eventOriginalTitle)
                time = "2:30pm"
                eventArray.append(time)
                eventArray.append("14:30")
                eventTitle = cell.eventOriginalTitle
                cell.selectionStyle = .none
                print(cell.eventOriginalTitle)
                print(cell.eventOriginalTitle)
                print(eventTitle)
                eventImage = cell.eventImage.image!
                eventTitles.insert(eventTitle, at: indexPath.row)
                eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                eventInfo.updateValue(eventArray, forKey: indexPath.row)
                print(eventInfo)
                eventImages.updateValue(eventImage, forKey: indexPath.row)
                print(eventList)
                //cell.hashtagTwo.text =
                
                print (eventArray)
                print(eventTitles)
                print(eventInfo)
                print(eventList)
                eventArray = []
                
                print(eventTitles)
                print(eventTitle)
                return cell
            }
            if indexPath.row == 1 {
                print("CELL IS TWO")

                let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                cell.hashtagOne.text = "bureaucracy"
                cell.hashtagTwo.text = "engagement"
                cell.eventOriginalTitle = "City Election"
                cell.eventTitle.text = spacer + cell.eventOriginalTitle
                cell.eventDescription.text = "Annual Race for Mayor"
                cell.eventDate.text = "June 1st"
                cell.eventImage.image = #imageLiteral(resourceName: "Image-14")
                if firstTime == true {
                    cell.configure()
                }
                time = "3:30pm"
                eventImage = cell.eventImage.image!
                eventImages.updateValue(eventImage, forKey: indexPath.row)
                eventArray.append("6/1/17")
                eventArray.append(address)
                
                print("eventTitle")
                print(eventTitle)
                print(cell.eventOriginalTitle)
                eventArray.append(time)
                eventArray.append("15:30")

                eventTitle = cell.eventOriginalTitle
                cell.selectionStyle = .none
                
                print(cell.eventOriginalTitle)
                eventTitles.insert(eventTitle, at: indexPath.row)
                eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                eventInfo.updateValue(eventArray, forKey: indexPath.row)

                print(eventList)
               
                print(eventTitles)
                print(eventTitle)
                eventArray = []

                return cell
                
            }
            if indexPath.row == 2 {
                let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                print("eventTitle")
                print("CELL IS THREE")

                
                cell.hashtagOne.text = "fire-safety"
                cell.hashtagTwo.text = "committee"
                cell.eventOriginalTitle = "Fire-Rescue"
                cell.eventTitle.text = spacer + cell.eventOriginalTitle
                cell.eventDescription.text = "Quarterly meeting"
                cell.eventDate.text = "June 3rd"
                cell.eventImage.image = #imageLiteral(resourceName: "Image-8")
                time = "5:00pm"
                eventTitle = cell.eventOriginalTitle
                eventImage = cell.eventImage.image!
                eventImages.updateValue(eventImage, forKey: indexPath.row)
                eventArray.append("6/3/17")
                eventArray.append(address)
                cell.selectionStyle = .none
                if firstTime == true {
                    cell.configure()
                }
            
                eventArray.append(time)
                eventArray.append("17:00")


                eventInfo.updateValue(eventArray, forKey: indexPath.row)
                
                eventTitles.insert(eventTitle, at: indexPath.row)
                eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                print(eventList)
                print(cell.eventOriginalTitle)
                print("STOP HERE")
                print(eventTitles)
                
                print(eventTitles)
                eventArray = []

                print(eventTitle)
                return cell
                
            }
            
            if indexPath.row == 3 {
                let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                print("eventTitle")
                print("CELL IS THREE")
                
                
                cell.hashtagOne.text = "natural"
                cell.hashtagTwo.text = "legislation"
                cell.eventOriginalTitle = "Parks and Recreation"
                cell.eventTitle.text = spacer + cell.eventOriginalTitle
                cell.eventDescription.text = "Quarterly meeting"
                cell.eventDate.text = "June 3rd"
                cell.eventImage.image = #imageLiteral(resourceName: "fortlauderdalepark")
                time = "5:00pm"
                eventTitle = cell.eventOriginalTitle
                eventImage = cell.eventImage.image!
                eventImages.updateValue(eventImage, forKey: indexPath.row)
                eventArray.append("6/3/17")
                eventArray.append(address)
                cell.selectionStyle = .none
                if firstTime == true {
                    cell.configure()
                }
                
                eventArray.append(time)
                eventArray.append("17:00")
                
                
                eventInfo.updateValue(eventArray, forKey: indexPath.row)
                
                eventTitles.insert(eventTitle, at: indexPath.row)
                eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                print(eventList)
                print(cell.eventOriginalTitle)
                print("STOP HERE")
                print(eventTitles)
                
                print(eventTitles)
                eventArray = []
                
                print(eventTitle)
                return cell
    
                
            }
        }
            if selectedCity == "Boston" {
                if indexPath.row == 0 {
                    
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.selectionStyle = .none
                    cell.hashtagOne.text = "environmental"
                    cell.hashtagTwo.text = "legislation"
                    cell.eventOriginalTitle = arrayEvents[indexPath.row]
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventImage.image = #imageLiteral(resourceName: "Image-12")
                    print(eventTitles)
                    
                    eventImage = cell.eventImage.image!
                    eventImages.updateValue(eventImage, forKey: indexPath.row)
                    eventInfo.updateValue(eventArray, forKey: indexPath.row)

                    cell.eventDescription.text = "Meeting"
                    cell.eventDate.text = eventTimes[indexPath.row]
                    time = "6:00pm"
                    
                    address = "1 City Hall Square"

                    eventArray.append("6/13/17")
                    eventArray.append(address)
                    eventArray.append(time)
                    eventArray.append("10:00")
                    print(eventArray)
                    eventTitle = cell.eventOriginalTitle
                    
                    cell.selectionStyle = .none

                    print(cell.eventOriginalTitle)
                    if firstTime == true {
                        cell.configure()
                    }
                    
                    eventTitles.insert(eventTitle, at: indexPath.row)
                    eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                    eventInfo.updateValue(eventArray, forKey: indexPath.row)
                    eventArray = []

                    print(eventList)
                    print(eventTitle)
                    return cell
                }
                if indexPath.row == 1 {
                    print("CELL IS TWO")
                    
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.hashtagTwo.text = "bureaucracy"
                    cell.hashtagOne.text = "engagement"
                    cell.eventOriginalTitle = arrayEvents[indexPath.row]
                    address = "1 City Hall Square"

                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventDescription.text = "Election"
                    cell.eventDate.text = eventTimes[indexPath.row]
                    cell.eventImage.image = #imageLiteral(resourceName: "Image-13")
                    if firstTime == true {
                        cell.configure()
                    }
                    
                    time = "8:15pm"
                    eventImage = cell.eventImage.image!
                    eventImages.updateValue(eventImage, forKey: indexPath.row)
                    eventArray.append("5/25/17")
                    eventArray.append(address)
                    eventArray.append(time)
                    eventArray.append("20:15")


                    print("eventTitle")
                    print(eventTitle)
                    print(cell.eventOriginalTitle)
                    eventInfo.updateValue(eventArray, forKey: indexPath.row)

                    eventTitle = cell.eventOriginalTitle
                    cell.selectionStyle = .none
                    
                    print(cell.eventOriginalTitle)
                    eventTitles.insert(eventTitle, at: indexPath.row)
                    eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                    print(eventList)
                    print(eventTitles)
                    print(eventTitle)
                    eventArray = []

                    return cell
                    
                }
                
                if indexPath.row == 2 {
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.selectionStyle = .none
                    address = "1 City Hall Square"

                    cell.hashtagOne.text = "fire-safety"
                    cell.hashtagTwo.text = "committee"
                    cell.eventOriginalTitle = arrayEvents[indexPath.row]
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventDescription.text = "Quarterly meeting"
                    cell.eventDate.text = eventTimes[indexPath.row+1]
                    cell.eventImage.image = #imageLiteral(resourceName: "brownstone")
                    time = "7:00pm"
                    eventTitle = cell.eventOriginalTitle
                    eventImage = cell.eventImage.image!
                    eventImages.updateValue(eventImage, forKey: indexPath.row)
                    eventArray.append("6/3/17")
                    eventArray.append(address)
                    eventArray.append(time)
                    eventArray.append("16:00")

                    cell.selectionStyle = .none
                    if firstTime == true {
                        cell.configure()
                    }
                    
                    eventInfo.updateValue(eventArray, forKey: indexPath.row)

                    print(cell.eventOriginalTitle)
                    print("STOP HERE")
                    print(eventTitles)
                    
                    eventTitles.insert(eventTitle, at: indexPath.row)
                    print(eventTitles)
                    eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                    print(eventList)
                    print(eventTitle)
                    eventArray = []

                    return cell
                }
                if indexPath.row == 3 {
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.selectionStyle = .none
                    address = "1 City Hall Square"

                    cell.hashtagOne.text = "fire-safety"
                    cell.hashtagTwo.text = "committee"
                    cell.eventOriginalTitle = arrayEvents[indexPath.row+1]
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventDescription.text = "Quarterly meeting"
                    cell.eventDate.text = eventTimes[indexPath.row]
                    cell.eventImage.image = #imageLiteral(resourceName: "bostonPark")
                    time = "4:00pm"
                    eventTitle = cell.eventOriginalTitle
                    eventImage = cell.eventImage.image!
                    eventImages.updateValue(eventImage, forKey: indexPath.row)
                    eventArray.append("6/3/17")
                    eventArray.append(address)
                    eventArray.append(time)
                    eventArray.append("16:00")


                    cell.selectionStyle = .none
                    if firstTime == true {
                        cell.configure()
                    }
                    
                    eventInfo.updateValue(eventArray, forKey: indexPath.row)

                    print(cell.eventOriginalTitle)
                    print("STOP HERE")
                    print(eventTitles)
                    
                    eventTitles.insert(eventTitle, at: indexPath.row)
                    print(eventTitles)
                    eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                    print(eventList)
                    print(eventTitle)
                    eventArray = []

                    return cell
                }

            }
            
            
            
            
       firstTime = false
       print(firstTime)
        
       let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
       cell.configure()
       cell.selectionStyle = .none
       print(cell.eventOriginalTitle)
       print("this is the title")

        
       print("cell for row" )
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: false)
        print("selected")
        if selectedCity == "Fort Lauderdale" {
            if indexPath.row == 0 {
               
                indexofEvent = indexPath.row
                performSegue(withIdentifier: "showEvent", sender: nil)
            }
            if indexPath.row == 1 {
                let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
               
                indexofEvent = indexPath.row
                eventTitles.append(cell.eventOriginalTitle)

                performSegue(withIdentifier: "showEvent", sender: nil)

            }
            if indexPath.row == 2 {
                
                    indexofEvent = indexPath.row
                    performSegue(withIdentifier: "showEvent", sender: nil)
                    print(eventTitle)

                    
            }
            
            
            
            if indexPath.row == 3 {
                indexofEvent = indexPath.row
                performSegue(withIdentifier: "showEvent", sender: nil)
                print(eventTitle)
            }
            
            if indexPath.row > 3 {
                
                indexofEvent = indexPath.row
                print("index of event")
                print(indexofEvent)
                performSegue(withIdentifier: "showEvent", sender: nil)
                
                
            }

            
            
            
            
        }
        if selectedCity == "Boston" {
                    print("yo")
                
                    if indexPath.row == 0 {
                        
                        indexofEvent = indexPath.row
                        performSegue(withIdentifier: "showEvent", sender: nil)
                        
                        print(eventTitle)
                    }
                
                    if indexPath.row == 1 {
                        
                        indexofEvent = indexPath.row

                        performSegue(withIdentifier: "showEvent", sender: nil)
                        
                        print(eventTitle)
                        
                }
                
                if indexPath.row == 2 {
                    indexofEvent = indexPath.row
                    performSegue(withIdentifier: "showEvent", sender: nil)
                    
                    print(eventTitles)
                    
                }
            if indexPath.row == 3 {
                indexofEvent = indexPath.row
                performSegue(withIdentifier: "showEvent", sender: nil)
                
                print(eventTitles)
            }
            if indexPath.row > 3 {
            
                indexofEvent = indexPath.row
                print("index of event")
                print(indexofEvent)
                performSegue(withIdentifier: "showEvent", sender: nil)


            }

                
            }
    }

    
                
                


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEvent") {
            print("preparing view")
            print(firstTime)
            
            let EventDetailViewController = segue.destination as! EventDetailViewController
            EventDetailViewController.selectedEvents = eventTitles
            EventDetailViewController.indexofEvent = indexofEvent
            EventDetailViewController.eventList = eventList
            EventDetailViewController.eventImages = eventImages
            EventDetailViewController.eventInfo = eventInfo
            EventDetailViewController.selectedCity = selectedCity
        }
        

    }

    
    

}
