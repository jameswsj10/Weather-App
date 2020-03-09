//
//  WeeklyFeedTableVC.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import Foundation
import UIKit

extension WeatherDisplyVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        return cell
    }
    
    
}
