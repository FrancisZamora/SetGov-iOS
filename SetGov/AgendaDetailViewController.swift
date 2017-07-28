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

class AgendaDetailViewController: SetGovTableViewController, HeaderCallBack {
    var  numsections = 0
    var agendaImage = #imageLiteral(resourceName: "Image1")
    var eventTitle = " "
    var primaryTitle = " "
    var secondaryTitle = " "
    var tertiaryTitle = " "
    var agendaInfo = [Int:String]()
    var index = 0
    var paragraphArray = [[String]()]
    var agendaTitles = [String]()
    @IBOutlet var navTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle.title = eventTitle
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: {})
    }
    

    override func viewDidAppear(_ animated: Bool) {
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        self.numsections = 1
        print("numberofSections")
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberofRows")
        return 2
        
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row {
        case 0:
            return 275
        case 1:
            return 275
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        
        if (indexPath.row == 0) {
            let agendadetailHeader =  tableView.dequeueReusableCell(withIdentifier: "AgendaDetailHeader", for:indexPath) as! AgendaDetailHeader
            agendadetailHeader.selectionStyle = .none
            agendadetailHeader.agendaImage.image = agendaImage
            print(agendaInfo)
            
            agendadetailHeader.titleLabel.text = agendaTitles[index]
            
          
            agendadetailHeader.headerCallBack = self

            
            print("cell for row" )
            return agendadetailHeader
        }
        
        
        
        if(indexPath.row == 1) {
            let agendadetailComments = tableView.dequeueReusableCell(withIdentifier: "AgendaDetailComments", for:indexPath) as! AgendaDetailComments
            agendadetailComments.selectionStyle = .none
            if paragraphArray.isEmpty == true {
                agendadetailComments.commentField.text = "Agenda Details not available"
            }
            agendadetailComments.commentField.text = paragraphArray[index][0]
            agendadetailComments.disableEditing()
            
            return agendadetailComments
        }
        let agendadetailHeader =  tableView.dequeueReusableCell(withIdentifier: "AgendaDetailComments", for:indexPath) as! AgendaDetailComments
        agendadetailHeader.selectionStyle = .none
        
        return agendadetailHeader
        
    }

    
    


}
