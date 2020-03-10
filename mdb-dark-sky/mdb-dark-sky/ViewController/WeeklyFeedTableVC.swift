//
//  WeeklyFeedTableVC.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import Foundation
import UIKit

extension WeatherDisplayVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currWeekWeathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let currWeather = currWeekWeathers[indexPath.row]
        let date = APIManager.getDate(unix: currWeather.time)
        cell.DayOfWeek.text = APIManager.getDayOfWeek(date)
        cell.TempHi.text = "\(Int(currWeather.temperatureHigh!))"
        cell.TempLow.text = "\(Int(currWeather.temperatureLow!))"
        cell.WeatherImg.image = UIImage(named: currWeather.icon)
        cell.layer.backgroundColor = UIColor.clear.cgColor

        return cell
    }
    
    
}

