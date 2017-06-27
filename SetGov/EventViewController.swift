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
    var eventTimeNoFormat = [String]()
    var eventDescriptions = [String]()
    var descriptionArray = [String]()
    var eventID = [String]()
    var eventTimeFormatted = [String]()
    var eventHours = [[String]]()
    var finalArray =  [String]()
    var eventAddresses = [String]()
    var eventhashTags = [[String]]()
    var hrefArray = [String]()
    var fortLauderdaleEvents = [[String]]()
    var fortLauderdaleTitles = [String]()
    var fortLauderdaleDates = [String]()
    var fortLauderdaleDictionary = [Date:[String]]()
    var fortLauderdaleDate = [String]()
    var fortlauderdaleArray = [[String]()]
    
    
    @IBOutlet var cityDisplay: UINavigationItem!
    
    func isEven (num:Int) -> Bool {
        if num % 2 == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        print("EventViewController")
        self.setCity()
        print(selectedCity)
        self.parseHTML(html: "swag")
        self.splitEventDescription()
        self.seperateTime()
        self.filterDictionary()
        self.fetchEventData()
        print(fortLauderdaleDictionary)
        
        
        if selectedCity == "Boston" {
            self.hrefArray.remove(at: 0)
            print(hrefArray)
            print("we made it")

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func parseHTML(html:String) -> Void {
        if selectedCity == "Boston" {
            print("parsing Boston")
            let url = URL(string: "https://www.boston.gov/public-notices")
            print(url as Any)
            print("continue")
            guard let doc = HTML(url: url!, encoding: .utf8) else  {
                return
            }
            print(doc.title as Any)
            print(doc.body as Any)
        
            print("continue")
            
            //let regex =  try !NSRegularExpression (pattern:"<a\shref=\'(.*?)\'>.*?</a>")
            
           // var modifiedString = [regex stringByReplacingMatchesInString:inputString options:0 range:NSMakeRange(0, [inputString length]) withTemplate:@"$1"];
            

            
           // let regex = try! NSRegularExpression(pattern: "href='")
            //var newString = " "
            
            for link in doc.css("a, link") {
                print(link.text as Any)
                guard let uneditedHref = link["href"] else {
                    return
                }
                
                if uneditedHref.range(of:"/public-notices/") != nil {
                    hrefArray.append(uneditedHref)

                }
                
                
                
            }
            
            print(hrefArray)
    
            for notices in doc.css("a[href*='/public-notices/']") {
                print("configuring new string")
                //var newString = notices.
                //newString.
               // print(newString)
                
                var showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print("\(showString)\n")
                showString = showString.capitalized  // "Castration: The Advantages And The Disadvantages"

                titleEvents.updateValue(showString, forKey: self.numIterations)
                let currentValue = titleEvents[self.numIterations]
                var newArray = currentValue?.components(separatedBy: ",")
                print(newArray as Any)
                print(newArray?.count as Any)
                
                
                guard let x = (newArray?.count)  else {
                    return
                }
                
                guard let lastElement = newArray?[x-1] else {
                    return
                }
                eventID.append(lastElement)
                print(eventID)
                var finalArray = lastElement.components(separatedBy: ",")
                finalArray = finalArray[finalArray.count-1].components(separatedBy: " ")
                print(finalArray)
             
                var finalElement = finalArray[finalArray.count-1]
                print(finalElement)
                let decimalCharacters = CharacterSet.decimalDigits
                
                let decimalRange = finalElement.rangeOfCharacter(from: decimalCharacters)
                
                if decimalRange != nil {
                    finalElement = ("Docket " + finalElement)
                }
                descriptionArray.append(finalElement)
                print(descriptionArray)
                
                
                
                finalArray = []
                finalElement = " "
                
                

       
                
                self.numIterations = self.numIterations + 1
                print(titleEvents)
                print("\(showString)\n")
        
              
                print(descriptionArray)
                print("attempting to print event description")

                let regex = try! NSRegularExpression(pattern: "href='")
                
                if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                    print("regex string")
                    print("\(showString)\n")
                    print("string was printed once")
                    
                    
                    
                }
                print(descriptionArray)
                
                arrayEvents.append(showString)
                
            }
            
            
  
            
            for notices in doc.css(".thoroughfare") {
                
                var showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print("\(showString)\n")
                
                if showString.range(of:"Room") != nil {
                    
                    showString = "1 City Hall Square"
                }
                eventAddresses.append(showString)

                
                
            }

            

            
        
            for notices in doc.css(".date-display-single") {

                    self.numIterations = 0
                   
                    let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    print("\(showString)\n")
                    var newArray = showString.components(separatedBy: ",")
                    let newString = newArray[0]
                    let formattedDate = (newString + " 2017")
                    print(showString)
                    
                    let date = Date()
                    print(date)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yy"
                    guard let newDate = dateFormatter.date(from: formattedDate) else {
                        return
                    }
                    let dateString2 = dateFormatter.string(from: (newDate))
                    
                    let dateString = dateFormatter.string(from:date)
                    print(newDate)
                    print("this is the right string")
                    print (dateString)
                    print(dateString2)
                    eventTimeFormatted.append(dateString2)
                    
                    eventTimeNoFormat.append(newString)
                    
                    print(eventTimeNoFormat)
                    
                    let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
                    
                    if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                        //shows.add(showString)
                        
                        print("\(showString)\n")
                        print("string was printed twice")
                        
                    }
                    
                    print(eventTimeNoFormat)
                    print(eventTimeFormatted)
                    
                    
                    for notices in doc.css(".date-display-single") {
                        
                        self.numIterations = 0
                        
                        let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        print("\(showString)\n")
                        var newArray = showString.components(separatedBy: ",")
                        let newString = newArray[0]
                        let formattedDate = (newString + " 2017")
                        print(showString)
                        
                        let date = Date()
                        print(date)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yy"
                        guard let newDate = dateFormatter.date(from: formattedDate) else {
                            return
                        }
                        let dateString2 = dateFormatter.string(from: (newDate))
                        
                        let dateString = dateFormatter.string(from:date)
                        print(newDate)
                        print("this is the right string")
                        print (dateString)
                        print(dateString2)
                        eventTimeFormatted.append(dateString2)
                        
                        eventTimeNoFormat.append(newString)
                        
                        print(eventTimeNoFormat)
                        
                        let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
                        
                        if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                            //shows.add(showString)
                            
                            print("\(showString)\n")
                            print("string was printed twice")
                            
                        }
                    }
                    
                    print(eventTimeNoFormat)

                    var xy = 0
                    for notices in doc.css(".dl-d") {
                        print(eventTimeNoFormat[numIterations])
                        
                        print(xy)
                        xy = xy + 1
                        
                        if numIterations == 0 {
                        let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        print(showString)
                        let tempArray = showString.components(separatedBy: "-")
                        print(tempArray)
                        print(numIterations)
                        let eventHour = tempArray
                        print(eventHour)
                        
                        eventHours.append(eventHour)
                        
                          


                        
                 
                       
                        }
                    }
                    print(eventHours)
                    
                        

                    
                    
                }
            
           
            }
        
            if selectedCity == "Fort Lauderdale" {
                print("parsing Fort Lauderdale")
                let url = URL(string: "https://fortlauderdale.legistar.com/Calendar.aspx")
                             guard let doc = HTML(url: url!, encoding: .utf8) else  {
                    return
                }
                
                numIterations = 0
                
                for events in doc.css(".rgRow") {
                    
                    var showString = events.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    let trimmedString = showString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(showString)
                    
                    var newArray = showString.components(separatedBy: "\n")
                    
                    print(showString)
                    print(newArray)
                    
                    
                    print(showString)
                    
                    fortLauderdaleEvents.append(newArray)
                    fortLauderdaleEvents[numIterations][0] = fortLauderdaleEvents[numIterations][0].capitalized
                    fortLauderdaleEvents[numIterations][1] = fortLauderdaleEvents[numIterations][1].trimmingCharacters(in: .whitespaces)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM/dd/yyyy"
                    if let date = formatter.date(from: fortLauderdaleEvents[numIterations][1]) {
                        fortLauderdaleDictionary.updateValue(fortLauderdaleEvents[numIterations], forKey: date)
                    }
                    
                    
                    self.numIterations = self.numIterations + 1

                }
                print(fortLauderdaleDictionary)
                
                
                print(fortLauderdaleEvents.count)
                print(fortLauderdaleEvents[0][1])
    
            }
        }
    
    
    func filterDictionary() {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        print(day)
        print(month)
        
        
        for (key, value) in fortLauderdaleDictionary {
            print(key)
            print(month)
            print(calendar.component(.month, from: key ))
            var x = calendar.component(.month, from: key) == month && calendar.component(.day, from: key) < day
            var y = calendar.component(.month, from: key) < month
             if x == true  || y == true {
                print(key)
                fortLauderdaleDictionary.removeValue(forKey: key)
                
            }
            
        }
        
        
        
        let keys = Array(fortLauderdaleDictionary.keys)
        print(keys)
       
        let sorted = keys.sorted(by: {$0.timeIntervalSince1970 < $1.timeIntervalSince1970})
        for sort in sorted {
            print("SORT: \(sort)")
            guard let y = fortLauderdaleDictionary[sort] else {
                return
            }
            fortlauderdaleArray.append(y)
            

            
        }
        
        print(fortlauderdaleArray)
        
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
            let lastIndex = eventDescriptions.count
            descriptionArray.append(eventDescriptions[lastIndex])
            print(x)
            x = x + 1
            if x > count {
                return
            }


            
        }
        
      //  print(descriptionArray)
        
    }
    
    func seperateTime() {
        if selectedCity == "Fort Lauderdale" {
            return
        }
        arrayEvents.remove(at: 0)
        for (index, _) in eventTimeNoFormat.enumerated() {
            
            //print(eventTimeNoFormat[numIterations])
            //print(eventHours[numIterations][0])
            let splitString = eventHours[index][0].components(separatedBy: ",")
            print(splitString)
            print("formatted time" + eventTimeNoFormat[index])
            //print("we are looking for this" + eventHours[numIterations][1])
            if eventTimeNoFormat[index] == splitString[0] {
                print("true")
                print(eventHours[index][1])
                finalArray.append(eventHours[index][1])
            }
            //print(numIterations)
            //print(numIterations)
            
        }
        
        print(eventTimeNoFormat)
        
        if finalArray.count >= eventTimeNoFormat.count {
            return
        }
        print(finalArray)
        
    }
    
    
   func fetchEventData() {
    fortlauderdaleArray.remove(at: 0)
    if selectedCity == "Fort Lauderdale" {
        for (index,value) in fortlauderdaleArray.enumerated() {
            print("INDEX: \(index)")
            
           
            print(fortlauderdaleArray.count)
            print("ARRAY STARTS HERE")
            print(fortlauderdaleArray)
            print(index)
            print(fortlauderdaleArray[0][0])
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "MM/dd/yyyy"
            print(fortlauderdaleArray[index][1])
            let dateObj = dateformatter.date(from: fortlauderdaleArray[index][1])
            
            
            
            
            dateformatter.dateStyle = DateFormatter.Style.medium
            let now = dateformatter.string(from: dateObj!)

            print(fortlauderdaleArray[index][1])
            print(now as Any)
            
            print(now)
            
            var castedArray = now.components(separatedBy:",")
            print(castedArray)
            
            let date = castedArray[0]
            let y = fortlauderdaleArray[index][5].trimmingCharacters(in: .whitespacesAndNewlines)
            //let split = now.components.
            let event = Event(eventTitle: spacer + fortlauderdaleArray[index][0], eventAddress:"100 N Andrews Ave", eventUsers: ["Tim","Sam"], eventDescription: "Meeting", eventDate:date , eventImageName: "Image1", eventTime: y, eventTags: ["swag","swag"], loggedUser: User(userName: "Tim", attendingStatus: false, interestedStatus: false))
            
           dataList.append(event)

        }
    }
    
     if selectedCity == "Boston" {
        for (index, value) in arrayEvents.enumerated() {
            print(descriptionArray[0])
            //let event = Event(eventTitle: spacer + arrayEvents[evt], eventDescription: descriptionArray[evt], eventDate: eventTimeNoFormat[evt], eventImage: "boston" + string(evt), eventTime = finalArray[evt] loggedUser = "Tim", eventAddress =  eventAddresses[evt], eventTags = ["engagement", "bureaucracy"])
            let event = Event(eventTitle: spacer + value, eventAddress: eventAddresses[index], eventUsers: ["Tim","Sam"] , eventDescription: descriptionArray[index], eventDate:eventTimeNoFormat[index], eventImageName: "bostonPark", eventTime: finalArray[index], eventTags: ["engagement", "bureaucracy"], loggedUser: User(userName: "Tim", attendingStatus: false, interestedStatus: false))
            
            print(event.eventDescription)
            
            if isEven(num: index) == true {
                event.eventImage = #imageLiteral(resourceName: "brownstone")
            }
            else {
                event.eventImage = #imageLiteral(resourceName: "bostonPark")
            }
                dataList.append(event)
        }
        }
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
        print("numberofRows")
        if selectedCity == "Boston" {
            return arrayEvents.count

        }
        
        else {
            return 4
        }
        
    }
    
   

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(finalArray)
        
        print(indexPath.row)
        print(arrayEvents)
        print(selectedCity)
        
        
        if selectedCity == "Boston" {
            
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
            cell.selectionStyle = .none
            print(dataList)
            
            cell.editCell(Event:dataList[indexPath.row])
            eventImage = cell.eventImage.image!
            eventImages.updateValue(eventImage, forKey: indexPath.row)
            
           
            
            return cell
            
        }
         if selectedCity == "Fort Lauderdale" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            print(dataList)
            
            cell.selectionStyle = .none
            cell.editCell(Event:dataList[indexPath.row])
            eventImage = cell.eventImage.image!
            eventImages.updateValue(eventImage,forKey: indexPath.row)
            return cell
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
            let EventDetailViewController = segue.destination as! EventDetailViewController
            EventDetailViewController.selectedEvents = eventTitles
            EventDetailViewController.indexofEvent = indexofEvent
            EventDetailViewController.eventList = eventList
            EventDetailViewController.eventImages = eventImages
            EventDetailViewController.eventInfo = eventInfo
            EventDetailViewController.selectedCity = selectedCity
            EventDetailViewController.arrayEvents = arrayEvents
            EventDetailViewController.eventTimeFormatted = eventTimeFormatted
            EventDetailViewController.finalArray = finalArray
            EventDetailViewController.EventAddresses = eventAddresses
            EventDetailViewController.hrefArray = hrefArray
            EventDetailViewController.descriptionArray = descriptionArray
        }
    }
}
