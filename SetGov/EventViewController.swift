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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        print("EventViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        tableView.deselectRow(at: indexPath, animated: false)
        print("selected")
        performSegue(withIdentifier: "showEvent", sender: nil)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)

        if (indexPath.row == 0){
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
            cell.selectionStyle = .none
            cell.configure()
            cell.hashtagOne.text = "environmental"
            cell.hashtagTwo.text = "committee"
            cell.eventTitle.text = spacer + "Marine Advisory"
            cell.eventDescription.text = "Tuck Tuck Tours"
            cell.eventDate.text = "May 2nd"

            
            
            
            
            
            
            
        }
        if (indexPath.row == 1) {
            print("indexPath is 1")
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
            cell.selectionStyle = .none
            cell.configure()
            cell.hashtagOne.text = "commmission"
            cell.hashtagTwo.text = "city"
            cell.eventTitle.text = spacer + "City Council"
            cell.eventDescription.text = "Bi-Monthly meeting"
            cell.eventDate.text = "May 25th"
            cell.eventImage.image = #imageLiteral(resourceName: "Image-7")
            return cell
         
            
        }
        if (indexPath.row == 2 ) {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
            cell.selectionStyle = .none
            cell.configure()
            cell.hashtagOne.text = "fire-safety"
            cell.hashtagTwo.text = "committee"
            cell.eventTitle.text = spacer + "Fire-Rescue"
            cell.eventDescription.text = "Quarterly meeting"
            cell.eventDate.text = "June 3rd"
            cell.eventImage.image = #imageLiteral(resourceName: "Image-8")
            return cell

        }
        
        
       let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
       cell.configure()
        
        
       //print("cell for row" )
       return cell
    }
    

    
    

}
