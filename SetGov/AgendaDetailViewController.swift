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
    var selectedCity = " "
    var agenda: Agenda!
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
            let x = String(agenda.text.characters.count)
            let y = Double(x)
            let z = y! * 0.55
            return CGFloat(z)
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        
        if (indexPath.row == 0) {
            let agendaDetailHeader =  tableView.dequeueReusableCell(withIdentifier: "AgendaDetailHeader", for:indexPath) as! AgendaDetailHeader
            agendaDetailHeader.configure(agenda: agenda)
            agendaDetailHeader.agendaImage.image = agendaImage
            agendaDetailHeader.headerCallBack = self
            return agendaDetailHeader
        }        
        
        if(indexPath.row == 1) {
            let agendaDetailComments = tableView.dequeueReusableCell(withIdentifier: "AgendaDetailComments", for:indexPath) as! AgendaDetailComments
            
            agendaDetailComments.configure(text: agenda.text)
            return agendaDetailComments
        }
        let agendaDetailComments =  tableView.dequeueReusableCell(withIdentifier: "AgendaDetailComments", for:indexPath) as! AgendaDetailComments
        agendaDetailComments.selectionStyle = .none
        return agendaDetailComments
        
    }

    
    


}
