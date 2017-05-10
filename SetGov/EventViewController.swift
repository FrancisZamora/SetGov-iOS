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
    var firstVisited = [Bool]()
    var eventList = [Int:String]()
    
    @IBOutlet var cityDisplay: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        print("EventViewController")
        self.setCity()
        print(selectedCity)
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setCity() {
        if selectedCity == "Fort Lauderdale" {
           cityDisplay.title = "Fort Lauderdale"
            
        }
        if selectedCity == "Boston"
        {
            cityDisplay.title = "Boston"
            
        }
        if selectedCity == "New York City" {
            cityDisplay.title = "New York City"
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
        return 30
        
    }
    
   

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        if selectedCity == "Fort Lauderdale" {
            if indexPath.row == 0 {
                
                print("CELL IS ONE")
                let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                cell.hashtagOne.text = "commmission"
                cell.hashtagTwo.text = "city"
                cell.eventOriginalTitle = "City Council"
                cell.eventTitle.text = spacer + cell.eventOriginalTitle
                cell.eventDescription.text = "Bi-Monthly meeting"
                cell.eventDate.text = "May 25th"
                cell.eventImage.image = #imageLiteral(resourceName: "Image-7")
                cell.configure()
                
                print("eventTitle")
                print(eventTitle)
                print("TESTING")
                print(cell.eventOriginalTitle)

                eventTitle = cell.eventOriginalTitle
                cell.selectionStyle = .none
                print(cell.eventOriginalTitle)
                print(cell.eventOriginalTitle)
                print(eventTitle)
                eventTitles.insert(eventTitle, at: indexPath.row)
                eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                print(eventList)

                
                print(eventTitles)
                print(eventTitle)
                return cell
            }
            if indexPath.row == 1 {
                print("CELL IS TWO")

                let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                cell.hashtagTwo.text = "city"
                cell.eventOriginalTitle = "Annual Race for Mayor"
                cell.eventTitle.text = spacer + cell.eventOriginalTitle
                cell.eventDescription.text = "Bi-Monthly meeting"
                cell.eventDate.text = "May 25th"
                cell.eventImage.image = #imageLiteral(resourceName: "Image-7")
                cell.configure()
                
                print("eventTitle")
                print(eventTitle)
                print(cell.eventOriginalTitle)
                
                eventTitle = cell.eventOriginalTitle
                cell.selectionStyle = .none
                
                print(cell.eventOriginalTitle)
                eventTitles.insert(eventTitle, at: indexPath.row)
                eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                print(eventList)
               
                print(eventTitles)
                print(eventTitle)

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
                eventTitle = cell.eventOriginalTitle
                
                cell.selectionStyle = .none
                cell.configure()
                eventTitles.insert(eventTitle, at: indexPath.row)
                eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                print(eventList)
                print(cell.eventOriginalTitle)
                print("STOP HERE")
                print(eventTitles)
                
                print(eventTitles)
                
                print(eventTitle)
                return cell
                
            }
        }
            if selectedCity == "Boston" {
                
                if indexPath.row == 0 {
                    
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.selectionStyle = .none
                    cell.hashtagOne.text = "environmental"
                    cell.hashtagTwo.text = "committee"
                    cell.eventOriginalTitle = "City Council"
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventImage.image = #imageLiteral(resourceName: "Image-7")
                    print(eventTitles)

                    cell.eventDescription.text = "Meeting"
                    cell.eventDate.text = "May 23rd"
                    
                    
                    eventTitle = cell.eventOriginalTitle
                    
                    cell.selectionStyle = .none

                    print(cell.eventOriginalTitle)
                    cell.configure()
                    eventTitles.insert(eventTitle, at: indexPath.row)
                    eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                    print(eventList)
                    print(eventTitle)
                    return cell
                }
                if indexPath.row == 1 {
                    print("CELL IS TWO")
                    
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.hashtagTwo.text = "city"
                    cell.eventOriginalTitle = "Annual Race for Mayor"
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventDescription.text = "Bi-Monthly meeting"
                    cell.eventDate.text = "May 25th"
                    cell.eventImage.image = #imageLiteral(resourceName: "Image-7")
                    cell.configure()
                    
                    print("eventTitle")
                    print(eventTitle)
                    print(cell.eventOriginalTitle)
                    
                    eventTitle = cell.eventOriginalTitle
                    cell.selectionStyle = .none
                    
                    print(cell.eventOriginalTitle)
                    eventTitles.insert(eventTitle, at: indexPath.row)
                    eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                    print(eventList)
                    print(eventTitles)
                    print(eventTitle)
                    
                    return cell
                    
                }
                
                if indexPath.row == 2 {
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.selectionStyle = .none

                    cell.hashtagOne.text = "fire-safety"
                    cell.hashtagTwo.text = "committee"
                    cell.eventOriginalTitle = "Fire-Rescue"
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventDescription.text = "Quarterly meeting"
                    cell.eventDate.text = "June 3rd"
                    cell.eventImage.image = #imageLiteral(resourceName: "Image-8")
                    eventTitle = cell.eventOriginalTitle
                    
                    cell.selectionStyle = .none
                    cell.configure()
                    
                    print(cell.eventOriginalTitle)
                    print("STOP HERE")
                    print(eventTitles)
                    
                    eventTitles.insert(eventTitle, at: indexPath.row)
                    print(eventTitles)
                    eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                    print(eventList)
                    print(eventTitle)
                    return cell
                }
                if indexPath.row == 3 {
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.selectionStyle = .none
                    
                    cell.hashtagOne.text = "fire-safety"
                    cell.hashtagTwo.text = "committee"
                    cell.eventOriginalTitle = "Nuclear Waste Clean Up"
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventDescription.text = "Quarterly meeting"
                    cell.eventDate.text = "June 3rd"
                    cell.eventImage.image = #imageLiteral(resourceName: "Image-8")
                    eventTitle = cell.eventOriginalTitle
                    
                    cell.selectionStyle = .none
                    cell.configure()
                    
                    print(cell.eventOriginalTitle)
                    print("STOP HERE")
                    print(eventTitles)
                    
                    eventTitles.insert(eventTitle, at: indexPath.row)
                    print(eventTitles)
                    eventList.updateValue(cell.eventOriginalTitle, forKey: indexPath.row)
                    print(eventList)
                    print(eventTitle)
                    return cell
                }

            }
            
            
            
            

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

        }
        

    }

    
    

}
