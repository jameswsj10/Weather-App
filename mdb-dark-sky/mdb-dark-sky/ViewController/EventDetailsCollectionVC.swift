//
//  EventDetailsCollectionVC.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import Foundation
import UIKit

extension WeatherDisplyVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        
        return cell
    }
    
    
}
