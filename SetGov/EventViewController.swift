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
        return 3
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       self.EventCell =  tableView.dequeueReusableCell(withIdentifier: "EventCell", for:indexPath) as! EventCell
       self.EventCell.hashtagOne.layer.backgroundColor  = SG_RED_COLOR.cgColor
       self.EventCell.hashtagTwo.layer.backgroundColor = SG_SECONDARY_BLUECOLOR.cgColor
       self.EventCell.hashtagTwo.layer.cornerRadius = self.EventCell.hashtagTwo.frame.height/3
       self.EventCell.hashtagOne.layer.cornerRadius = self.EventCell.hashtagOne.frame.height/3
       self.EventCell.hashtagTwo.layer.masksToBounds = false
               
        


        



       print("cell for row" )
       return EventCell
    }
    

    
    

}
