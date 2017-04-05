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

    var count = 0
    var numsections = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberofRows")
        return 50
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        tableView.deselectRow(at: indexPath, animated: false)
        print("selected")
        performSegue(withIdentifier: "showEvent", sender: nil)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 1) {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
            cell.configure()
            cell.eventTitle.text = "  City Council"
            cell.eventDescription.text = "Monthly meeting"
            cell.eventDate.text = "Feb 23th"
            cell.eventImage.image = #imageLiteral(resourceName: "Image-7")
         
            
        }
        if (indexPath.row == 2 ) {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
            cell.configure()
            cell.eventTitle.text = "  Fire-Rescue"
            cell.eventDescription.text = "Monthly meeting"
            cell.eventDate.text = "Jan 3rd"
            cell.eventImage.image = #imageLiteral(resourceName: "Image-8")
            return cell

        }
        
        
        
       let cell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
        cell.configure()
        
        
       print("cell for row" )
       return cell
    }
    

    
    

}
