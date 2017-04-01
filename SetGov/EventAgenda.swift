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
    
    
    @IBOutlet weak var agendaCollectionView: UICollectionView!
    
    @IBOutlet var agenda: UILabel!
    
    
    override func awakeFromNib() {
        print("EventAgenda")
        agendaCollectionView.delegate = self
        agendaCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaCell", for: indexPath) as! AgendaCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
       // cell.mLabel.text = "CELL: \(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
}
