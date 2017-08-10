//
//  EventAgenda.swift
//  SetGov
//
//  Created by Francis Zamora on 3/27/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import Kanna


protocol EventAgendaCallback: class {
    func loadAgendaDetail(data:Dictionary<Int,String>, infoData:[[String]], agendaTitles:[String], index: Int)
    func loadVC()
}

class EventAgenda: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var agenda: UILabel!
    @IBOutlet weak var agendaCollectionView: UICollectionView!
    var agendaInfo = [Int: String]()
    var index = 0
    weak var eventAgendaCallback: EventAgendaCallback!
    var hrefArray = [String]()
    var indexofEvent = 0
    var selectedCity = " "
    var agendaArray = [String]()
    var agendaStringArray = [[String]()]
    var agendaTitles = [String]()
    var descriptionArray = [String]()
    var eventDescription = String()
    var secondUrl = String()
    var agendaTitle = [String]()
    var paragraphArray = [[String]()]
    var currentEvent: Event!

    
    override func awakeFromNib() {
        print("EventAgenda")
        agendaCollectionView.delegate = self
        agendaCollectionView.dataSource = self
    }
    
    func configureLauderdale() {
        self.agenda.text = "Agenda & Meeting Details"
    }
    
    func configureCell(event: Event) {
        selectionStyle = .none
        currentEvent = event
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      
        
        if selectedCity == "Boston" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
            cell.configureCell(agenda: currentEvent.agendaItems[indexPath.row])
            agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)
            return cell
    
            
        }
        if selectedCity == "Fort Lauderdale" {
            //self.prepareAgenda()

            if (indexPath.row == 0) {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell

                cell.mLabel.text = "Agenda"
                cell.topicLabel.text = eventDescription
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                
                agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)
                
                return cell
            }
            
            if (indexPath.row == 1) {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
                cell.mLabel.text = "Meeting Details"
                
                cell.topicLabel.text = eventDescription
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                
                agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)
                
                return cell
            }

        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedCity == "Fort Lauderdale" {
            return 2
        }
        //self.generateBoston()
        //self.prepareAgenda()
        
        return currentEvent.agendaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
    
        index = indexPath.row
        print("ROW 0")
        print(agendaInfo)
        agendaInfo.updateValue(cell.topicLabel.text!,
                               forKey: indexPath.row)
        print(cell.topicLabel.text as Any)
        
        print(agendaInfo)
        

        if let callback = eventAgendaCallback {

            callback.loadAgendaDetail(data: agendaInfo,
                                      infoData: paragraphArray,
                                      agendaTitles:agendaTitles,
                                      index:indexPath.row)
            
            callback.loadVC()

        }
    }
}
