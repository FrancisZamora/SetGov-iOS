//
//  WebScraper.swift
//  SetGov
//
//  Created by Balin on 8/9/17
//  Original Scraper created by Francis 
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import Kanna
class WebScraper {
 
        fileprivate static func parseBoston() -> (arrayEvents: [String],
            descriptionArray: [String],
            eventAddresses: [String],
            eventHours: [[String]],
            eventTimeFormatted: [String],
            hrefArray: [String]) {
                
                var hrefArray = [String]()
                var descriptionArray = [String]()
                var numIterations = 0
                var arrayEvents = [String]()
                var eventAddresses = [String]()
                var eventTimeNoFormat = [String]()
                var eventHours = [[String]]()
                
                print("parsing Boston")
                let url = URL(string: "https://www.boston.gov/public-notices")
                print(url as Any)
                print("continue")
                guard let doc = HTML(url: url!, encoding: .utf8) else  {
                    return ([],[],[],[],[],[])
                }
                print(doc.title as Any)
                print(doc.body as Any)
                
                print("continue")
                for link in doc.css("a, link") {
                    print("LINK TEXT: \(link.text as Any)" )
                    guard let uneditedHref = link["href"] else {
                        
                        return ([],[],[],[],[],[])
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
                    
                    var newArray = showString.components(separatedBy: ",")
                    
                    let lastElement = newArray[newArray.count-1]
                    
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
                    
                    finalArray = []
                    finalElement = " "
                    
                    numIterations = numIterations + 1
                    
                    print("attempting to print event description")
                    
                    let regex = try! NSRegularExpression(pattern: "href='")
                    
                    if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                        print("regex string")
                        print("\(showString)\n")
                        print("string was printed once")
                    }
                    
                    arrayEvents.append(showString)
                    
                }
                
                for notices in doc.css(".thoroughfare") {
                    
                    var showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    
                    if showString.range(of:"Room") != nil {
                        
                        showString = "1 City Hall Square"
                    }
                    
                    eventAddresses.append(showString)
                    
                }
                
                numIterations = 0
                for notices in doc.css(".date-display-single") {
                    let showString = notices.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    eventTimeNoFormat.append(showString)
                    numIterations = numIterations + 1
                    
                }
                eventTimeNoFormat = self.cleanseArray(eventTimeNoFormat: eventTimeNoFormat)
                let eventTimeFormatted = self.breakTime(eventTimeNoFormat: eventTimeNoFormat)
                
                
                numIterations = 0
                for notices in doc.css(".dl-d") {
                    
                    if numIterations == 3 {
                        numIterations = 0
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
                    numIterations = numIterations + 1
                }
                
                arrayEvents.remove(at: 0)
                hrefArray.remove(at: 0)
                
                
                return (arrayEvents,descriptionArray,eventAddresses,eventHours,eventTimeFormatted,hrefArray)
                //print("HREF ARRAY: \(self.hrefArray)")
        }
        
        fileprivate static func buildBostonAgendaItems(hrefArray: [String],
                                                       descriptionArray: [String]) -> [Int : [Agenda]] {
            
            var agendaTitles = [String]()
            var agendaStringArray = [[String]]()
            var paragraphArray = [[String]]()
            var agendaDictionary = [Int : [Agenda]]()
            
            
            for (index, secondUrl) in hrefArray.enumerated() {
                paragraphArray.removeAll()
                agendaTitles.removeAll()
                agendaStringArray.removeAll()
                let url = URL(string: "https://www.boston.gov" + secondUrl)
                
                
                guard let doc = HTML(url: url!, encoding: .utf8) else  {
                    return [:]
                }
                
                for a in doc.css("strong") {
                    
                    let showString = a.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    
                    print(showString)
                    agendaTitles.append(showString)
                }
                
                // seg fault is here
                for link in doc.css(".body") {
                    let showString = link.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    let agendaString = showString.components(separatedBy: "\n")
                    let agendaTitle = [agendaString][0]
                    let x = [agendaTitle][0]
                    agendaStringArray.append(x)
                    for paragraph in doc.css("p") {
                        let showString = paragraph.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        print(showString)
                        let agendaString = showString.components(separatedBy: "\n")
                        paragraphArray.append(agendaString)
                        
                    }
                }
                paragraphArray.remove(at: 0)
                paragraphArray.remove(at: 0)
                
                var agendaList = [Agenda]()
                
                print("AGENDA TITLES SIZE: \(agendaTitles.count)")
                print("DESCRIPTION ARRAY SIZE: \(descriptionArray.count)")
                print(" ")
                print("AGENDA TITLES: \(agendaTitles)")
                print("DESCRIPTION ARRAY : \(descriptionArray)")
                
                
                
                
                for title in agendaTitles {
                    agendaList.append(Agenda(name: title, description: descriptionArray[index]))
                }
                
                agendaDictionary[index] = agendaList
                
                print("AGENDA:: TITLES: \(agendaTitles)")
                print("AGENDA:: STRING ARRAY: \(agendaStringArray)")
                print("AGENDA:: PARAGRAPH: \(paragraphArray)")
                print(" ")
            }
            
            return agendaDictionary
            
        }
        
        fileprivate static func breakTime(eventTimeNoFormat: [String]) -> [String] {
            
            print("BREAK TIME: \(eventTimeNoFormat)")
            
            let dateFormatter = DateFormatter()
            var dateArray = [Date]()
            dateFormatter.dateFormat = "MM/dd/yy"
            //var dupArray = eventTimeNoFormat
            var format = [String]()
            var eventTimeFormatted = [String]()
            
            for value in eventTimeNoFormat {
                
                if let x = dateFormatter.date(from: value) {
                    dateArray.append(x)
                    format.append(dateFormatter.string(from: x))
                }
            }
            
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            //Is this necessary?  All of the responses are coming back in the proper MM/dd/yy format
            
            //        for value in eventTimeNoFormat {
            //            //if let x = dateFormatter.date(from: dupArray[index]) {
            //            if let x = dateFormatter.date(from: value) {
            //                dateArray.append(x)
            //                //let y = dateFormatter.string(from: dateArray[index])
            //                format.append(dateFormatter.string(from: x))
            //            }
            //        }
            
            for value in format {
                var x = value.components(separatedBy: ",")
                eventTimeFormatted.append(x[0])
            }
            
            print("BREAK TIME RESULTS: \(eventTimeFormatted)")
            
            return eventTimeFormatted
        }
        
        fileprivate static func cleanseArray(eventTimeNoFormat: [String]) -> [String] {
            
            print("CLEANSING ARRAY: \(eventTimeNoFormat)")
            
            var indexArray = [Int]()
            for (index, value) in eventTimeNoFormat.enumerated() {
                if value.range(of:":") != nil {
                    indexArray.append(index)
                }
            }
            
            let formatted = eventTimeNoFormat.enumerated().filter { !indexArray.contains($0.offset) }.map { $0.element }
            
            print("FORMATTED ARRAY: \(formatted)")
            
            return formatted
            
        }
        
        fileprivate static func buildBostonEvents(agendaDictionary: [Int : [Agenda]],
                                                  arrayEvents: [String],
                                                  descriptionArray: [String],
                                                  eventAddresses: [String],
                                                  eventHours: [[String]],
                                                  eventTimeFormatted: [String]) {
            
            print("BUILD BOSTON EVENTS: \(eventTimeFormatted)")
            guard eventTimeFormatted.count > 0 else {
                print("EVENT TIME FORMATTED IS EMPTY")
                return
            }
            
            //self.descriptionArray.remove(at: 0)
            let spacer = "  "
            
            for (index, value) in eventAddresses.enumerated() {
                
                let event = Event(title: spacer + arrayEvents[index],
                                  address: value,
                                  users: [],
                                  description: descriptionArray[index],
                                  date:eventTimeFormatted[index],
                                  eventImageName: "bostonPark",
                                  time: eventHours[index][1],
                                  city: "Boston", agendaItems: agendaDictionary[index]! , 
                                  id: 0)
                
                if index % 2 == 0 {
                    event.image = #imageLiteral(resourceName: "brownstone")
                } else {
                    event.image = #imageLiteral(resourceName: "bostonPark")
                }
                
                ApiClient.addEvent(event: event,onCompletion: { (success) in
                    
                    print("JSON HERE")
                    //                    print(json["data"]["addEvent"]["id"])
                    //                        guard let id = eventID.int else {
                    //                            return
                    //
                    //                        }
                    //                        print(id)
                    //                        self.bostonIDS.append(id)
                    //                        print("THESE ARE THE IDS")
                    //                        print(self.bostonIDS)
                    
                })
                //dataList.append(event)
            }
            
            
        }
        
        static func parseEvents() {
            
            print("PARSING EVENTS!!!!!")
            
            DispatchQueue.global().async() {
                let results = parseBoston()
                let agendaDictionary = buildBostonAgendaItems(hrefArray: results.hrefArray,
                                                              descriptionArray: results.descriptionArray)
                buildBostonEvents(agendaDictionary: agendaDictionary,
                                  arrayEvents: results.arrayEvents,
                                  descriptionArray: results.descriptionArray,
                                  eventAddresses: results.eventAddresses,
                                  eventHours: results.eventHours,
                                  eventTimeFormatted: results.eventTimeFormatted)
                
            }
            
            //parseFortLauderdale()
            //            if self.selectedCity == "Boston" {
            //
            //
            //            }
            
            
            
            //            if self.selectedCity == "Fort Lauderdale" {
            //                print("parsing Fort Lauderdale")
            //                let url = URL(string: "https://fortlauderdale.legistar.com/Calendar.aspx")
            //                guard let doc = HTML(url: url!, encoding: .utf8) else  {
            //                    return
            //                }
            //
            //                self.numIterations = 0
            //
            //                for events in doc.css(".rgRow") {
            //
            //                    let showString = events.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            //                    _ = showString.trimmingCharacters(in: .whitespacesAndNewlines)
            //
            //                    let newArray = showString.components(separatedBy: "\n")
            //
            //                    self.fortLauderdaleEvents.append(newArray)
            //                    self.fortLauderdaleEvents[self.numIterations][0] = self.fortLauderdaleEvents[self.numIterations][0].capitalized
            //                    self.fortLauderdaleEvents[self.numIterations][1] = self.fortLauderdaleEvents[self.numIterations][1].trimmingCharacters(in: .whitespaces)
            //                    let formatter = DateFormatter()
            //                    formatter.dateFormat = "MM/dd/yyyy"
            //                    if let date = formatter.date(from: self.fortLauderdaleEvents[self.numIterations][1]) {
            //                        self.fortLauderdaleDictionary.updateValue(self.fortLauderdaleEvents[self.numIterations], forKey: date)
            //                    }
            //                    
            //                    
            //                    self.numIterations = self.numIterations + 1
            //                    
            //                }
            //                
            //                for events in doc.css(".rgAltRow") {
            //                    
            //                    let showString = events.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            //                    _ = showString.trimmingCharacters(in: .whitespacesAndNewlines)
            //                    print(showString)
            //                    
            //                    let newArray = showString.components(separatedBy: "\n")
            //                    self.fortLauderdaleEvents.append(newArray)
            //                    self.fortLauderdaleEvents[self.numIterations][0] = self.fortLauderdaleEvents[self.numIterations][0].capitalized
            //                    self.fortLauderdaleEvents[self.numIterations][1] = self.fortLauderdaleEvents[self.numIterations][1].trimmingCharacters(in: .whitespaces)
            //                    let formatter = DateFormatter()
            //                    formatter.dateFormat = "MM/dd/yyyy"
            //                    print(self.fortLauderdaleEvents)
            //                    if let date = formatter.date(from: self.fortLauderdaleEvents[self.numIterations][1]) {
            //                        self.fortLauderdaleDictionary.updateValue(self.fortLauderdaleEvents[self.numIterations], forKey: date)
            //                    }
            //                    
            //                    
            //                    self.numIterations = self.numIterations + 1
            //                    
            //                }
            //                
            //                print(self.fortLauderdaleDictionary)
            //                
            //                
            //                print(self.fortLauderdaleEvents.count)
            //                
            //                print(self.fortLauderdaleEvents[0][1])
            //                
            //            }
            
            
            
            //self.buildAgendaItems()
            //self.fetchEventData()
            
            
            
            
        }
        
    }



