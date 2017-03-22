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
    var EventCell: EventCell!

    var count = 0
    var numsections = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false

        print("Table View for Events")
    }
       func sizeUp() {
        self.EventCell.hashtagTwo.layer.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:0.0).cgColor
        self.EventCell.hashtagOne.layer.backgroundColor = UIColor(red:0.93,green:0.93, blue:0.93, alpha:0.0).cgColor
        self.EventCell.hashtagTwo.layer.cornerRadius = self.EventCell.hashtagTwo.frame.height/2
        self.EventCell.hashtagOne.layer.cornerRadius = self.EventCell.hashtagOne.frame.height/2
        self.EventCell.hashtagOne.clipsToBounds = true
        self.EventCell.hashtagOne.layer.masksToBounds = false
        self.EventCell.willShape()
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
        self.EventCell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        performSegue(withIdentifier: "showEvent", sender: EventCell)
    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       self.EventCell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
       sizeUp()
       print("cell for row" )
       return EventCell
    }
    

    
    

}
