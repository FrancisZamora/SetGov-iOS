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

protocol EventAgendaCallback: class {
    func loadAgendaDetail(data:Dictionary<Int,String>, index: Int)
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

    
    override func awakeFromNib() {
        print("EventAgenda")
        agendaCollectionView.delegate = self
        agendaCollectionView.dataSource = self
    }
    
    func generateBoston() {
        if selectedCity == "Boston" {
            secondUrl = hrefArray[indexofEvent]
        }
    }
    
    func configureLauderdale() {
        self.agenda.text = "Agenda & Meeting Details"
    }
    
    func prepareAgenda() {
        if selectedCity == "Fort Lauderdale" {
            configureLauderdale()
        }
        
        if selectedCity == "Boston" {
            let url = URL(string: "https://www.boston.gov" + secondUrl)
    
        
            guard let doc = HTML(url: url!, encoding: .utf8) else  {
                return
            }
            
            for a in doc.css("strong") {
                
                
            let showString = a.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
            print(showString)
            agendaTitles.append(showString)
                
                
            }
            
            print(agendaTitles)

        // seg fault is here
          for link in doc.css(".body") {
            let showString = link.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let agendaString = showString.components(separatedBy: "\n")
            agendaTitle = [agendaString][0]
            let x = [agendaTitle][0]
            agendaStringArray.append(x)
            for paragraph in doc.css("p") {
                let showString = link.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                print(showString)
                
            }
            
            
            
          }
            print(agendaStringArray)
        
            print(agendaArray)
    
    
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        self.generateBoston()
        self.prepareAgenda()
        if selectedCity == "Boston" {
            if (indexPath.row == 0) {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
                cell.configureCell(title: agendaTitles[indexPath.row])

                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                cell.configureCell(title: agendaTitles[indexPath.row])
                
                
                cell.topicLabel.text = descriptionArray[indexofEvent]
                agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)

                return cell
        }
        if (indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
            print(agendaTitles[1])
            
            cell.configureCell(title: agendaTitles[indexPath.row])
            cell.mLabel.text = "Expand Las Olas"
            cell.topicLabel.text = "Ordinance"
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            
            agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)

            return cell

        }
        if (indexPath.row == 2) {
           
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
                print(agendaTitles)
            
                cell.configureCell(title: agendaTitles[indexPath.row])

                cell.mLabel.text = "Waterworks"
                cell.topicLabel.text = "Safety"
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
            
                agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)
                print(agendaInfo)
            
                return cell
            
        }
        }
        if selectedCity == "Fort Lauderdale" {
            self.prepareAgenda()

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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
    
        if (indexPath.row == 0 ) {
            index = indexPath.row
            print("ROW 0")
            print(agendaInfo)
            agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)
            print(cell.topicLabel.text as Any)
            
            print(agendaInfo)
            

            if let callback = eventAgendaCallback {

                callback.loadAgendaDetail(data: agendaInfo,index:0)
                
                callback.loadVC()


            }
        }
        
        if (indexPath.row == 1 ) {
           index = indexPath.row
            print("ROW 1")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
            agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)

            if let callback = eventAgendaCallback {
                callback.loadAgendaDetail(data: agendaInfo,index:1)
                callback.loadVC()

            }

        }
        
        if (indexPath.row == 2 ) {
           index = indexPath.row
            print("ROW 2")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
            agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)

            if let callback = eventAgendaCallback {
                callback.loadAgendaDetail(data: agendaInfo,index:2)
                callback.loadVC()

                
            }

        }
        
    }
    
    
}
    


