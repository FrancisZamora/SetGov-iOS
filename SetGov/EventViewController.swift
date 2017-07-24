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
    var eventAddresses = [String]()
    var eventhashTags = [[String]]()
    var hrefArray = [String]()
    var fortLauderdaleEvents = [[String]]()
    var fortLauderdaleTitles = [String]()
    var fortLauderdaleDates = [String]()
    var fortLauderdaleDictionary = [Date:[String]]()
    var fortLauderdaleDate = [String]()
    var fortlauderdaleArray = [[String]()]
    var dateArray = [Date]()
    var user: User!
    var fortlauderdaleIDS = [Int]()
    var bostonIDS = [Int]()
    
    
    
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
        print(selectedCity)
        self.user = self.appDelegate.user

        print(self.user.fullName)
        
               self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .white
        print("EventViewController")
        self.setCity()
        print(selectedCity)
        self.parseHTML(html: "swag")
        self.splitEventDescription()
        self.filterDictionary()
        self.fetchEventData()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)

        if UserDefaults.standard.integer(forKey: "eventoverLay") != 1 {

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                     self.performSegue(withIdentifier: "overLay", sender: nil)
            
            }
        }
        UserDefaults.standard.set(1,forKey:"eventoverLay")
        
        print(fortLauderdaleDictionary)
        print(UserDefaults.standard.integer(forKey: "eventoverLay"))
        
        if selectedCity == "Boston" {
            self.hrefArray.remove(at: 0)
            print(hrefArray)
            print("we made it")

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func refresh(sender:AnyObject) {
        print("refreshed")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.refreshControl?.endRefreshing()
            print("stop refreshing")
        }
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
                
                var showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                if showString.range(of:"Room") != nil {
                    
                    showString = "1 City Hall Square"
                }
                
                eventAddresses.append(showString)

            }
            
            self.numIterations = 0
            for notices in doc.css(".date-display-single") {
                    let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    eventTimeNoFormat.append(showString)
                    self.numIterations = self.numIterations + 1

                
                
            }
                    self.cleanseArray()
                    self.breakTime()
            

                    self.numIterations = 0
                    for notices in doc.css(".dl-d") {
                        
                        if self.numIterations == 3 {
                            self.numIterations = 0
                        }
                        if numIterations == 0 {
                            let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                            print(showString)
                            let tempArray = showString.components(separatedBy: "-")
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
                    
                    let newArray = showString.components(separatedBy: "\n")
    
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
                    fortLauderdaleEvents.append(newArray)
                    fortLauderdaleEvents[numIterations][0] = fortLauderdaleEvents[numIterations][0].capitalized
                    fortLauderdaleEvents[numIterations][1] = fortLauderdaleEvents[numIterations][1].trimmingCharacters(in: .whitespaces)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM/dd/yyyy"
                    print(fortLauderdaleEvents)
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
        for (key, _) in fortLauderdaleDictionary {
            
            let x = calendar.component(.month, from: key) == month && calendar.component(.day, from: key) < day
            let y = calendar.component(.month, from: key) < month
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
        var dupArray = eventTimeNoFormat
        var format = [String]()
        
        for (index,_) in eventTimeNoFormat.enumerated() {

            guard let  x = dateFormatter.date(from: eventTimeNoFormat[index]) else {
                
                return
                
            }
            dateArray.append(x)
            eventTimeNoFormat[index] = dateFormatter.string(from: x)
        }
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        
        for (index,_) in eventTimeNoFormat.enumerated() {
            guard let  x = dateFormatter.date(from: dupArray[index]) else {
                
                return
            }
            dateArray.append(x)
            
             let y = dateFormatter.string(from: dateArray[index])
             format.append(y)
        }
        
        print(eventTimeNoFormat)
        
        for (index, _) in format.enumerated() {
            var x = format[index].components(separatedBy: ",")
            eventTimeFormatted.append(x[0])
            
        }
        print(eventTimeFormatted)
        
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
            let zz = fortlauderdaleArray[index][6].trimmingCharacters(in: .whitespacesAndNewlines)

            

            let event = Event(eventTitle: spacer + fortlauderdaleArray[index][0], eventAddress:"100 N Andrews Ave", eventUsers: [" "], eventDescription: finalTitle, eventDate:date , eventImageName: "Image1", eventTime: zz, eventCity: "Fort Lauderdale")
            print("THIS IS THE EVENT TIME")
            print(zz)
            
            if isEven(num: count) {
                event.eventImage = #imageLiteral(resourceName: "Image-12")
                
            }
            
            if count % 3 == 0 {
                event.eventImage = #imageLiteral(resourceName: "fortlauderdalepark")
            }
            
            
            ApiClient.addEvent(event: event,onCompletion: { (json) in
                let eventID = json["data"]["createEvent"]
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    guard let id = eventID.int else {
                        return
                    }
                
                  self.fortlauderdaleIDS.append(id)
                }
            })
           count = count + 1
           dataList.append(event)

        }
    }
    
     if selectedCity == "Boston" {
        
        self.descriptionArray.remove(at: 0)
        
        for (index, value) in eventAddresses.enumerated() {
            
            let event = Event(eventTitle: spacer + arrayEvents[index], eventAddress: value, eventUsers: [" "] , eventDescription: descriptionArray[index], eventDate:eventTimeFormatted[index], eventImageName: "bostonPark", eventTime: eventHours[index][1], eventCity: "Boston")
            
                if isEven(num: index) == true {
                    event.eventImage = #imageLiteral(resourceName: "brownstone")
                }
                else {
                    event.eventImage = #imageLiteral(resourceName: "bostonPark")
                }
            
            ApiClient.addEvent(event: event,onCompletion: { (json) in
                let eventID = json["data"]["addEvent"]["id"]
                print(eventID)
                print("JSON HERE")
                print(json["data"]["addEvent"]["id"])
                    guard let id = eventID.int else {
                        return
                        
                    }
                    print(id)
                    self.bostonIDS.append(id)
                    print(self.bostonIDS)
                    
                    
                
            })
                    
            
            
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
        for (index, value) in eventTimeNoFormat.enumerated() {
           if value.range(of:":") != nil {
               indexArray.append(index)
            }
        }
        eventTimeNoFormat = eventTimeNoFormat.enumerated().filter { !indexArray.contains($0.offset) }.map { $0.element }
    
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
            cell.alpha = 0.50
            
            UIView.animate(withDuration: 0.88) {
                cell.alpha = 1
            }
            
            eventImage = cell.eventImage.image!
            eventImages.updateValue(eventImage, forKey: indexPath.row)
            
            return cell
        }
         if selectedCity == "Fort Lauderdale" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            cell.selectionStyle = .none
            cell.editCell(Event:dataList[indexPath.row])
            cell.alpha = 0
            UIView.animate(withDuration: 1.0) {
                cell.alpha = 1
            }
            
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
            EventDetailViewController.dataList = dataList
            EventDetailViewController.eventInfo = eventInfo
            EventDetailViewController.selectedCity = selectedCity
            EventDetailViewController.arrayEvents = arrayEvents
            EventDetailViewController.eventTimeNoFormat = eventTimeNoFormat
            EventDetailViewController.EventAddresses = eventAddresses
            EventDetailViewController.hrefArray = hrefArray
            EventDetailViewController.descriptionArray = descriptionArray
            EventDetailViewController.eventHours = eventHours
            EventDetailViewController.fortlauderdaleArray = fortlauderdaleArray
            EventDetailViewController.bostonIDS = bostonIDS
            EventDetailViewController.fortlauderdaleIDS = fortlauderdaleIDS
        }
    }
}
