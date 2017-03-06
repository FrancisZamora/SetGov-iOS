//
//  EventViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 3/6/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit

class EventViewController: SetGovTableViewController {
    var activate = true
    var count = 0
    var numsections = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.numsections = 1
        return numsections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath as IndexPath) as! EventCell
        print("cell for row" )
       
        return cell
    }
    

    
    

}
