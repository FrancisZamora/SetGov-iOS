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

class EventAgenda: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var agenda: UILabel!
    @IBOutlet weak var agendaCollectionView: UICollectionView!
    var agendaInfo = [Int: String]()
    var index = 0
    var agendaDetailViewController: AgendaDetailViewController?
    
    override func awakeFromNib() {
        print("EventAgenda")
        agendaCollectionView.delegate = self
        agendaCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if (indexPath.row == 0) {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                cell.mLabel.text = "Tuck Tuck Tour"
                cell.topicLabel.text = "Licensing"
                agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)

                // cell.mLabel.text = "CELL: \(indexPath.row)"
                return cell
        }
        if (indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell

            cell.mLabel.text = "Expand Las Olas"
            cell.topicLabel.text = "Ordinance"
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)

            return cell

        }
        if (indexPath.row == 2) {
           
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
                cell.mLabel.text = "Waterworks"
                cell.topicLabel.text = "Safety"
                cell.layer.cornerRadius = 10
                cell.layer.masksToBounds = true
                agendaInfo.updateValue(cell.topicLabel.text!, forKey: indexPath.row)
                print(agendaInfo)
            
                return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        agendaDetailViewController?.agendaInfo = agendaInfo

        if (indexPath.row == 0 ) {
            agendaDetailViewController?.index = indexPath.row
            
        }
        if (indexPath.row == 1 ) {
           agendaDetailViewController?.index = indexPath.row
            
        }
        if (indexPath.row == 2 ) {
            agendaDetailViewController?.index = indexPath.row
            
        }
    }

}
