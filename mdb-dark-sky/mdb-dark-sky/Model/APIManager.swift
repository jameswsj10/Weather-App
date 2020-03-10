//
//  APIManager.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class APIManager {
    
    // to fetch current single weather
    static func fetchWeather(_ fullURL: String, _ completionHandler: @escaping (Weather) -> Void) {
        
        guard let url = URL(string: fullURL) else {
            return
        }
    
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
    
            let request = try! JSONDecoder().decode(WeatherRequest.self, from: data)
            completionHandler(request.currently)
            
            print("REQUEST>CURRENTLY: \(request.currently)")
        }
        print("done")
        task.resume()
    }
    
    // to fetch list of weathers
    static func fetchForecast(_ fullURL: String, _ completionHandler: @escaping ([Weather]) -> Void) {
    guard let url = URL(string: fullURL) else {
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            let request = try! JSONDecoder().decode(WeatherRequest.self, from: data)
            completionHandler(request.daily)
            
        }
        task.resume()
    }
    
    static func getDayOfWeek(_ today: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateNoTime = formatter.date(from: today)
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: dateNoTime!)
        switch weekDay{
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        case 7:
            return "Sunday"
        default:
            return "Day not found"
        }
    }
    
    static func getDate(unix: Double) -> String{
        let nsdate = NSDate(timeIntervalSince1970: unix)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: nsdate as Date))
        return formatter.string(from: nsdate as Date)
    }
    
}
