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
    func loadAgendaDetail(agenda: Agenda)
}

class EventAgenda: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var agenda: UILabel!
    @IBOutlet weak var agendaCollectionView: UICollectionView!
   // var agendaInfo = [Int: String]()
  //  var index = 0
    weak var eventAgendaCallback: EventAgendaCallback!
  //  var hrefArray = [String]()
    //var indexofEvent = 0
    var selectedCity = " "
//    var agendaArray = [String]()
//    var agendaStringArray = [[String]()]
//    var agendaTitles = [String]()
//    var descriptionArray = [String]()
//    var eventDescription = String()
//    var secondUrl = String()
//    var agendaTitle = [String]()
//    var paragraphArray = [[String]()]
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
        cell.configureCell(agenda: currentEvent.agendaItems[indexPath.row])
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
        
        if let callback = eventAgendaCallback {

            callback.loadAgendaDetail(agenda: currentEvent.agendaItems[indexPath.row])
            
        }
    }
}
