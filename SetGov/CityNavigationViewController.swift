//
//  CityNavigationViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 4/23/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class CityNavigationViewController: SetGovTableViewController {
    var numsections = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return 223
        case 1:
            return 223
        case 2:
            return 223
      
        default:
            return 240
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0 ) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BostonCell", for:indexPath) as! BostonCell
            cell.selectionStyle = .none
            print(indexPath.row)
           
            return cell

        }
        
        if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FortLauderdaleCell", for:indexPath) as! FortLauderdaleCell
            cell.selectionStyle = .none
            print(indexPath.row)
            return cell

        }
        if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewYorkCityCell", for:indexPath) as! NewYorkCityCell
            
            print(indexPath.row)
           // if cell.isSelected == true {
                print("cell was selected")
                let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            //}
            return cell

            
        }
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FortLauderdaleCell", for:indexPath) as! FortLauderdaleCell
        return cell
        
      }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        

        if (indexPath.row == 2) {
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
    
    }
}
