//
//  WeatherAPI.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


extension WeatherDisplayVC: CLLocationManagerDelegate {
    
    func getAPI(_ WeatherUrl: String) {
        print("updating current weather")

        APIManager.fetchWeather(WeatherUrl, { data in
            self.currWeather = data

            DispatchQueue.main.async {
                self.updateCurrWeather()
            }
        })
        
        APIManager.fetchForecast(WeatherUrl, { data in
            self.currWeekWeathers = data
            DispatchQueue.main.async {
                self.thisWeekTable.reloadData()
            }
        })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0] as CLLocation
        print("THIS IS THE DATE: \(userLocation.timestamp)")
        manager.stopUpdatingLocation()
        
        if !isSearching {
            print("\(longitude) longitude updated")
            self.longitude = userLocation.coordinate.longitude
            self.latitude = userLocation.coordinate.latitude
        }
        
        print("current coordinates are: \(longitude), \(latitude)")
        
        // deal with diff date if we search
        if let date = DateString {
            defaultUrl = "\(urlkey)\(self.latitude ?? userLocation.coordinate.latitude),\(self.longitude ??  userLocation.coordinate.longitude),\(date)"
            print("coorddinates of date searched")
        } else {
            defaultUrl = "\(urlkey)\(self.latitude ?? userLocation.coordinate.latitude),\(self.longitude ?? userLocation.coordinate.longitude)"
            print("regular coordinates")
        }
        getAPI(defaultUrl)
    }
    
    func determineCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    // called when the authorization status is changed for the core location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
    }
    
    
}
