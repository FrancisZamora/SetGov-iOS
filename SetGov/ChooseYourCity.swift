//
//  ChooseYourCity.swift
//  SetGov
//
//  Created by Francis Zamora on 9/25/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class ChooseYourCity:  UICollectionViewController {
    
    @IBOutlet var layout: UICollectionViewFlowLayout!
    @IBOutlet var cities: UICollectionView!
    override func viewDidLoad() {
         super.viewDidLoad()
        layout.minimumInteritemSpacing =  0
        layout.minimumLineSpacing      = 0
    }
    override func awakeFromNib() {
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boston", for: indexPath)
            return cell
        }
        
        if indexPath.row == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fortlauderdale", for: indexPath) 
            return cell
        }
        if indexPath.row == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phoenix", for: indexPath) 
            return cell
        }
        if indexPath.row == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "miami", for: indexPath) 
            return cell
        }
        if indexPath.row == 4 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "austin", for: indexPath) 
            return cell
        }
        if indexPath.row == 5 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sanjose", for: indexPath) 
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sanjose", for: indexPath) 
        return cell

        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
}
}
