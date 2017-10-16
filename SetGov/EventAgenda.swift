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
import PDFReader

protocol EventAgendaCallback: class {
    func loadAgendaDetail(agenda: Agenda)
    func createPDF()
}

class EventAgenda: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var comingSoon: UILabel!
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
        selectionStyle = .none
        currentEvent = event
        if selectedCity == "Fort Lauderdale" {
          
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
        if currentEvent.city == "Fort Lauderdale" {
            var AgendaArray = [Agenda]()
            let x = Agenda(name: "Agenda", description:"Meeting", text: "Agenda Details Not Available")
           
            AgendaArray.append(x)

            cell.configureCell(agenda:AgendaArray[indexPath.row])
            return cell
        }
        cell.configureCell(agenda: currentEvent.agendaItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentEvent.city == "Fort Lauderdale" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let fortlauderdalePDFS = appDelegate.fortlauderdalePDFLinks
            if  (fortlauderdalePDFS.count < indexofEvent + 1 )   {
                agendaCollection.isHidden = true
            } else {
                agendaCollection.isHidden = false
                //comingSoon.isHidden = true

                self.agendaCollection.reloadData()
                return 1
            }
        }
        
        if currentEvent.city == "Boston" {
            //comingSoon.isHidden = true
        }
        
        return currentEvent.agendaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentEvent.city == "Fort Lauderdale" {
            if let callback = eventAgendaCallback {
                callback.createPDF()
            }
            return 
        }
        
        if let callback = eventAgendaCallback {
            callback.loadAgendaDetail(agenda: currentEvent.agendaItems[indexPath.row])
        }
    }
}
