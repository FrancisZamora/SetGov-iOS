//
//  AgendaDetailViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 4/3/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class AgendaDetailViewController: SetGovTableViewController {
    var  numsections = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EventDetailViewController")
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
        return 6
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 38
        case 2:
            return 176
        case 3:
            return 94
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        
        if (indexPath.row == 0) {
            let agendadetailHeader =  tableView.dequeueReusableCell(withIdentifier: "AgendaDetailHeader", for:indexPath) as! AgendaDetailHeader
            
            
            print("cell for row" )
            return agendadetailHeader
        }
        
        if(indexPath.row == 1) {
            let agendadetailData =  tableView.dequeueReusableCell(withIdentifier: "AgendaDetailHeader", for:indexPath) as! AgendaDetailHeader
            return agendadetailData
        }
        
        if(indexPath.row == 2) {
            let agendadetailComments = tableView.dequeueReusableCell(withIdentifier: "AgendaDetailComments", for:indexPath) as! AgendaDetailComments
            
            return agendadetailComments
        }
        let agendadetailHeader =  tableView.dequeueReusableCell(withIdentifier: "AgendaDetailHeader", for:indexPath) as! AgendaDetailHeader
        
        return agendadetailHeader
        
    }

    
    














}
