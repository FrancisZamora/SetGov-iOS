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
    func loadAgendaDetail()
}

class EventAgenda: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var background: UIView!
    
    @IBOutlet weak var mEmptyAgendaLabel: UILabel!
    @IBOutlet var agenda: UILabel!
    @IBOutlet weak var agendaCollectionView: UICollectionView!
    //var agendaInfo = [Int: String]()
    //var index = 0
    weak var eventAgendaCallback: EventAgendaCallback!
    //var hrefArray = [String]()
    //var indexofEvent = 0
    var selectedCity = " "
    var currentEvent: Event!
    var indexofEvent = 0 

    @IBOutlet var agendaCollection: UICollectionView!
    
    override func awakeFromNib() {
        //print("EventAgenda")
        agendaCollectionView.delegate = self
        agendaCollectionView.dataSource = self
    }
    
    func configureLauderdale() {
        self.agenda.text = "Agenda & Meeting Details"
    }
    
    func configureCell(event: Event) {
        
        
        print("CONFIGURE AGENDA CELL: \(event.agendaLink)")
        
        
        
        background.layer.cornerRadius = 10
        selectionStyle = .none
        currentEvent = event
        if selectedCity == "Fort Lauderdale" {
          
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(currentEvent.agendaLink != "") {
            mEmptyAgendaLabel.isHidden = true
            return 1
        }
        mEmptyAgendaLabel.isHidden = false
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentEvent.city == "Fort Lauderdale" {
//            if let callback = eventAgendaCallback {
//                callback.createPDF()
//            }
            return 
        }
        
        if let callback = eventAgendaCallback {
            callback.loadAgendaDetail()
        }
    }
}
