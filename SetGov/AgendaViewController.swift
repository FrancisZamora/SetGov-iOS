//
//  AgendaViewController.swift
//  SetGov
//
//  Created by Francis Zamora on 3/28/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class AgendaViewController: UICollectionView {
    var numsections = 0
    
    func collectionView(collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
  
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell for row here we go")
        
        if (indexPath.row == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaItem1",for: indexPath)
            return cell
        }
        
        if(indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaItem2",for: indexPath)
            return cell
        }
        
        if(indexPath.row == 2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaItem3",for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgendaItem3",for: indexPath)
        return cell
    }
}
