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
    var testArray = [String]()
    var dateArray = [Date]()
    var formatArray = [String]()
    
    
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
    
    func cleanArray() {
        arrayEvents.remove(at: 0)

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
                var showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print("\(showString)\n")
                showString = showString.capitalized

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
                print("we made it")
                
                var showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print("\(showString)\n")
                
                if showString.range(of:"Room") != nil {
                    
                    showString = "1 City Hall Square"
                }
                print(showString)
                
                eventAddresses.append(showString)

            }
            
            print(eventAddresses)
            
            self.numIterations = 0
            for notices in doc.css(".date-display-single") {
                    print(numIterations)
                    let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    print("RIGHT STRING")
                    print("\(showString)\n")
                    print(showString)
                    testArray.append(showString)
                    var newArray = showString.components(separatedBy: ",")
                
                    let newString = newArray[0]
                
                    var formattedDate = (newString + ", 2017")
                
                
                    let date = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yy"
                
                    if formattedDate.range(of:"pm") != nil {
                        formattedDate = "June 30, 2017"
                    }
                
                
                    let newDate = dateFormatter.date(from: formattedDate)
                
                
                
                    let dateString2 = dateFormatter.string(from: newDate!)
                    dateFormatter.dateFormat = "MMM dd, yyyy"
                
                    let dateString = dateFormatter.string(from:date)
                    print(dateString)
                    let eventTimeArray = dateString.components(separatedBy: ",")

                    print(eventTimeArray)
                
                    let eventShortTime = eventTimeArray[0]
                    print(eventShortTime)
                
                
                    print(newDate)
                    print("this is the right string")
                    print (dateString)
                    print(dateString2)
                
                    eventTimeFormatted.append(dateString2)
                    
                    eventTimeNoFormat.append(eventShortTime)
                    
                    print(eventTimeNoFormat)
                    self.numIterations = self.numIterations + 1

                
                
            }
                    self.cleanseArray()
                    print(testArray)
                    self.breakTime()
            
                    print(eventTimeNoFormat)
                    print(eventTimeFormatted)
                    
                    
                    print(eventTimeNoFormat)

                    var xy = 0
                    self.numIterations = 0
                    for notices in doc.css(".dl-d") {
                        print("SWAG")
                        
                        print(xy)
                        xy = xy + 1
                        if self.numIterations == 3 {
                            self.numIterations = 0
                        }
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
                        self.numIterations = self.numIterations + 1
                    }
                    print(eventHours)
                    self.cleanArray()
            }
    
    
    
            if selectedCity == "Fort Lauderdale" {
                print("parsing Fort Lauderdale")
                let url = URL(string: "https://fortlauderdale.legistar.com/Calendar.aspx")
                guard let doc = HTML(url: url!, encoding: .utf8) else  {
                    return
                }
                
                numIterations = 0
                
                for events in doc.css(".rgRow") {
                    
                    let showString = events.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    _ = showString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(showString)
                    
                    let newArray = showString.components(separatedBy: "\n")
                    
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
                
                for events in doc.css(".rgAltRow") {
                    
                    let showString = events.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    _ = showString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(showString)
                    
                    let newArray = showString.components(separatedBy: "\n")
                    
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
       // print(day)
      //  print(month)
        
        
        for (key, _) in fortLauderdaleDictionary {
            print(key)
            //print(month)
            
            //print(calendar.component(.month, from: key ))
            //print(calendar.component(.month, from: key ) > month)
            
            let x = calendar.component(.month, from: key) == month && calendar.component(.day, from: key) < day
            let y = calendar.component(.month, from: key) < month
            //var z = calendar.component(.month, from: key) > month
             if (x == true  || y == true) {
                
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
    }
    
    func breakTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        var dupArray = testArray
        var format = [String]()
        
        for (index,_) in testArray.enumerated() {
            testArray[index].components(separatedBy: ",")

            guard let  x = dateFormatter.date(from: testArray[index]) else {
                
                return
                
            }
            dateArray.append(x)
            testArray[index] = dateFormatter.string(from: x)
        }
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        
        for (index,_) in testArray.enumerated() {
            guard let  x = dateFormatter.date(from: dupArray[index]) else {
                
                return
            }
            dateArray.append(x)
            
             let y = dateFormatter.string(from: dateArray[index])
             format.append(y)
        }
        
        print(testArray)
        
        for (index, _) in format.enumerated() {
            var x = format[index].components(separatedBy: ",")
            formatArray.append(x[0])
            
        }
        print(formatArray)
        
    }

    
        
    func seperateTime() {
        if selectedCity == "Fort Lauderdale" {
            return
        }
        arrayEvents.remove(at: 0)
        for (index, _) in eventTimeNoFormat.enumerated() {
            
            print(eventHours)
            
            let splitString = eventHours[index][0].components(separatedBy: ",")
            print(splitString)
            print("formatted time" + eventTimeNoFormat[index])
            //print("we are looking for this" + eventHours[numIterations][1])
            if eventTimeNoFormat[index] == splitString[0] {
                print("true")
                print(eventHours[index][1])
                finalArray.append(eventHours[index][1])
            }
        }
        
        print(eventTimeNoFormat)
        
        if finalArray.count >= eventTimeNoFormat.count {
            return
        }
        print(finalArray)
        
    }
    
   func fetchEventData() {
    var count = 0
    fortlauderdaleArray.remove(at: 0)
    if selectedCity == "Fort Lauderdale" {
        for (index,_) in fortlauderdaleArray.enumerated() {
         
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "MM/dd/yyyy"
            let dateObj = dateformatter.date(from: fortlauderdaleArray[index][1])
            
            dateformatter.dateStyle = DateFormatter.Style.medium
            let now = dateformatter.string(from: dateObj!)

            
            var castedArray = now.components(separatedBy:",")
            
            let date = castedArray[0]
            let y = fortlauderdaleArray[index][5].trimmingCharacters(in: .whitespacesAndNewlines)
            let z = fortlauderdaleArray[index][0].components(separatedBy: " ")
            let finalDescription = z
            let finalTitle = (finalDescription[finalDescription.count-1])
            
            

            let event = Event(eventTitle: spacer + fortlauderdaleArray[index][0], eventAddress:"100 N Andrews Ave", eventUsers: ["Tim","Sam"], eventDescription: finalTitle, eventDate:date , eventImageName: "Image1", eventTime: y, eventTags: ["swag","swag"], loggedUser: User(userName: "Tim", attendingStatus: false, interestedStatus: false))
            if isEven(num: count) {
                event.eventImage = #imageLiteral(resourceName: "Image-12")
                
            }
            
            if count % 3 == 0 {
                event.eventImage = #imageLiteral(resourceName: "fortlauderdalepark")
            }
            
           count = count + 1
           dataList.append(event)

        }
    }
    
     if selectedCity == "Boston" {
        self.descriptionArray.remove(at: 0)
        
        for (index, value) in eventAddresses.enumerated() {
            print(descriptionArray[0])
            print(eventAddresses.count)
            print(arrayEvents)
            print(arrayEvents.count)
            
           // print(eventAddresses[index])
            //print(eventTimeNoFormat)
            //print(descriptionArray[index])
            
            //print(eventTimeNoFormat[index])
            
           // print(arrayEvents)
            
            
            
            let event = Event(eventTitle: spacer + arrayEvents[index], eventAddress: value, eventUsers: ["Tim","Sam"] , eventDescription: descriptionArray[index], eventDate:eventTimeNoFormat[index], eventImageName: "bostonPark", eventTime: eventHours[index][1], eventTags: ["engagement", "bureaucracy"], loggedUser: User(userName: "Tim", attendingStatus: false, interestedStatus: false))

            //let event = Event(eventTitle: spacer + value, eventAddress: eventAddresses[index], eventUsers: ["Tim","Sam"] , eventDescription: descriptionArray[index], eventDate:eventTimeNoFormat[index], eventImageName: "bostonPark", eventTime: finalArray[index], eventTags: ["engagement", "bureaucracy"], loggedUser: User(userName: "Tim", attendingStatus: false, interestedStatus: false))
            
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
    
    func cleanseArray() {
        var indexArray = [Int]()
        for (index, value) in testArray.enumerated() {
           if value.range(of:":") != nil {
               indexArray.append(index)
            }
        }
        testArray = testArray.enumerated().filter { !indexArray.contains($0.offset) }.map { $0.element }
    
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
        
        if selectedCity == "Fort Lauderdale" {
            return fortlauderdaleArray.count
        }
        
        else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedCity == "Boston" {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
            cell.selectionStyle = .none
            
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
       let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
       cell.configure()
       cell.selectionStyle = .none
       return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: false)
        print("selected")
        if selectedCity == "Fort Lauderdale" {
            
            indexofEvent = indexPath.row
            performSegue(withIdentifier: "showEvent", sender: nil)
            
        }
        
        if selectedCity == "Boston" {
                    print("yo")
            indexofEvent = indexPath.row
            performSegue(withIdentifier: "showEvent", sender: nil)
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
            EventDetailViewController.eventHours = eventHours
            EventDetailViewController.fortlauderdaleArray = fortlauderdaleArray 
        }
    }
}
