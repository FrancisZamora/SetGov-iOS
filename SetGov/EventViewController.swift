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

    
    @IBOutlet var cityDisplay: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        print("EventViewController")
        self.setCity()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberofRows")
        return 3
        
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
                eventTitles.append(eventTitle)
                print(eventTitles)
                print(eventTitle)
                return cell
            }
            if indexPath.row == 1 {
                print("CELL IS TWO")

                let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                cell.hashtagTwo.text = "city"
                cell.eventOriginalTitle = "City Council"
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
                eventTitles.append(cell.eventOriginalTitle)
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
                eventTitles.append(cell.eventOriginalTitle)
                cell.configure()

                print(cell.eventOriginalTitle)
                print("STOP HERE")
                print(eventTitles)
                
                eventTitles.append(cell.eventOriginalTitle)
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
                    cell.eventDescription.text = "Meeting"
                    cell.eventDate.text = "May 23rd"
                    
                    
                    eventTitle = cell.eventOriginalTitle
                    
                    cell.selectionStyle = .none
                    eventTitle.append(cell.eventOriginalTitle)

                    print(cell.eventOriginalTitle)
                    cell.configure()
                    eventTitles.append(cell.eventOriginalTitle)

                    print(eventTitle)
                    return cell
                }
                if indexPath.row == 1 {
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.selectionStyle = .none
                    cell.hashtagOne.text = "vote"
                    cell.hashtagTwo.text = "electoral"
                    cell.eventOriginalTitle = "Annual Race for Mayor"
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventDescription.text = "Election"
                    cell.eventDate.text = "May 23rd"
                    
                    
                    eventTitle = cell.eventOriginalTitle
                    
                    cell.selectionStyle = .none
                    eventTitle.append(cell.eventOriginalTitle)

                    print(cell.eventOriginalTitle)
                    cell.configure()
                    eventTitles.append(cell.eventOriginalTitle)

                    print(eventTitle)
                    return cell
                    
                }
                
                if indexPath.row == 2 {
                    let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
                    cell.selectionStyle = .none
                    cell.hashtagOne.text = "environmental"
                    cell.hashtagTwo.text = "committee"
                    cell.eventOriginalTitle = "Council"
                    cell.eventTitle.text = spacer + cell.eventOriginalTitle
                    cell.eventDescription.text = "Meeting"
                    cell.eventDate.text = "May 23rd"
                    cell.configure()

                    
                    eventTitle = cell.eventOriginalTitle
                    
                    cell.selectionStyle = .none
                    eventTitle.append(cell.eventOriginalTitle)

                    print(cell.eventOriginalTitle)
                    eventTitles.append(cell.eventOriginalTitle)

                    print(eventTitle)
                    return cell
                    
                }
            }
            
            
            
            

       let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
       cell.configure()
        
        
       //print("cell for row" )
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
            if selectedCity == "Boston" {
                
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

                

                
                }

            
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEvent") {

            let EventDetailViewController = segue.destination as! EventDetailViewController
            EventDetailViewController.selectedEvents = eventTitles
            EventDetailViewController.indexofEvent = indexofEvent
        }
        

    }

    
    

}
