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
        
        
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0.0

        cities.collectionViewLayout = layout
    
    }
    override func awakeFromNib() {
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fortlauderdale", for: indexPath)
            
            return cell
        }
        
        if indexPath.row == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boston", for: indexPath)
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

        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "austin", for: indexPath)
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
        if (indexPath.row == 2) {
            let alert = UIAlertController(title: "Phoenix Coming Soon", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (indexPath.row == 3) {
            let alert = UIAlertController(title: "Miami Coming Soon", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (indexPath.row == 4) {
            let alert = UIAlertController(title: "Austin Coming Soon", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (indexPath.row == 5) {
            let alert = UIAlertController(title: "San Jose Coming Soon", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

}
}
