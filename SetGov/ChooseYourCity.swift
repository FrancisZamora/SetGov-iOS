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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var layout: UICollectionViewFlowLayout!
    @IBOutlet var cities: UICollectionView!
    override func viewDidLoad() {
        print("ChooseYourCity")
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        if UserDefaults.standard.integer(forKey: "cityoverLay") != 1 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                self.performSegue(withIdentifier: "overLay", sender: nil)
            }
        }
        UserDefaults.standard.set(1,forKey:"cityoverLay")

        let screenSize = UIScreen.main.bounds
  
        let size = CGSize(width: screenSize.width / 2, height: screenSize.height / 3)
        layout.itemSize = size
            // Setting the space between cells
        
        
        layout.sectionInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0.0

        cities.collectionViewLayout = layout
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionCell", for: indexPath) as! CityCollectionCell
        
        let city = appDelegate.cities[indexPath.row]
        cell.configure(city: city)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        if indexPath.row == 0 {
            print("Fort Lauderdale Cell")
            ApiClient.setHomeCity(city: "Fort Lauderdale")
            UserDefaults.standard.set("Fort Lauderdale",forKey:"homeCity")
            ApiClient.setHomeCity(city: "Fort Lauderdale")
            UserDefaults.standard.set("Fort Lauderdale",forKey:"homeCity")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
            guard let city = UserDefaults.standard.string(forKey: "homeCity") else {
                return
            }
            controller.selectedCity = city
            
            show(controller, sender: nil)
        }
        if indexPath.row == 1 {
            print("Boston Cell")
            ApiClient.setHomeCity(city: "Boston")
            UserDefaults.standard.set("Boston",forKey:"homeCity")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
            guard let city = UserDefaults.standard.string(forKey: "homeCity") else {
                return
            }
            controller.selectedCity = city
            
            show(controller, sender: nil)
        }
        
    }
}
