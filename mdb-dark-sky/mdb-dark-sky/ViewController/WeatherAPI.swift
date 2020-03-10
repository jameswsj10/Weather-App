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
    
    func getAPI(_ WeatherUrl: String, _ ForecastUrl: String) {
        print("updating current weather")

        APIManager.fetchWeather(WeatherUrl, { data in
            self.currWeather = data

            DispatchQueue.main.async {
                self.updateCurrWeather()
            }
        })
        
        APIManager.fetchForecast(ForecastUrl, { data in
            self.currWeekWeathers = data
            self.thisWeekTable.reloadData()
//            DispatchQueue.main.async {
//                self.thisWeekTable.reloadData()
//            }
        })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0] as CLLocation
        print("THIS IS THE DATE: \(userLocation.timestamp)")
        manager.stopUpdatingLocation()
        defaultUrl = "\(urlkey)\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        self.longitude = userLocation.coordinate.longitude
        self.latitude = userLocation.coordinate.latitude
        
//        print(longitude, latitude)
        getAPI(defaultUrl, defaultUrl)
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
