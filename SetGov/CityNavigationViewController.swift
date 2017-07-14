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
    //user ns user default
    @IBOutlet var navBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 213
        if UserDefaults.standard.integer(forKey: "cityoverLay") != 1 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                self.performSegue(withIdentifier: "overLay", sender: nil)
            }
        }
        UserDefaults.standard.set(1,forKey:"cityoverLay")
        print(UserDefaults.standard.integer(forKey:"cityoverLay"))
        

        
    }
  
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
        return 4
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            //223 for iphone 7 <
            return 247
        case 1:
            //223 for iphone 7 <
            return 247
        case 2:
            //223 for iphone 7 <
            return 247
      
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
            cell.selectionStyle = .none
            //cell.selectionStyle = UITableViewCellSelectionStyle.blue
           // cell.isUserInteractionEnabled = true
            print(indexPath.row)
           // if cell.isSelected == true {
            print("cell was selected")
                           //}
            return cell

            
        }
        if (indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MiamiCell", for:indexPath) as! MiamiCell
            cell.selectionStyle = .none
            //cell.selectionStyle = UITableViewCellSelectionStyle.blue
            // cell.isUserInteractionEnabled = true
            print(indexPath.row)
            // if cell.isSelected == true {
            print("cell was selected")
            //}
            return cell
            
            
        }

        let cell =  tableView.dequeueReusableCell(withIdentifier: "FortLauderdaleCell", for:indexPath) as! FortLauderdaleCell
        return cell
        
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "boston") {
            let EventViewController = segue.destination as! EventViewController
            EventViewController.selectedCity = "Boston"
            
        }
        if (segue.identifier == "fort lauderdale") {
            let EventViewController = segue.destination as! EventViewController
            EventViewController.selectedCity = "Fort Lauderdale"
            
        }
        if (segue.identifier == "new york ") {
            let EventViewController = segue.destination as! EventViewController
            EventViewController.selectedCity = "New York City"
            
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print(indexPath.row)
        
        if indexPath.row == 0 {

            print("Boston Cell")
        }
        
        if indexPath.row == 1 {

            print("Fort Lauderdale Cell")
            
        }
        
        if (indexPath.row == 2) {
            let alert = UIAlertController(title: "New York City Coming Soon", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
            
        }
        
        if (indexPath.row == 3) {
            let alert = UIAlertController(title: "Miami Coming Soon", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            
            
        }

    
    }
}
