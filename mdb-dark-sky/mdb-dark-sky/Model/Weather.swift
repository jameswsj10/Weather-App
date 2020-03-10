//
//  Weather.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//
import Foundation

class WeatherRequest: Decodable{
    let currently: Weather
    let daily: [Weather]
    
    enum CodingKeys:String, CodingKey {
        case daily, currently
    }
    
    enum DataKeys: String, CodingKey {
        case data
    }

    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.currently = try valueContainer.decode(Weather.self, forKey: .currently)
        let dailyContainer = try valueContainer.nestedContainer(keyedBy: DataKeys.self, forKey: .daily)
        
        self.daily = try dailyContainer.decode([Weather].self, forKey: .data)
    }
}

struct Weather: Decodable{
    var time: Double
    var summary: String
    var icon: String
    var precipProbability: Double
    var precipType: String!
    var windSpeed: Double
    var temperature: Double!
    var apparentTemperature: Double!
    var temperatureHigh: Double!
    var temperatureLow: Double!
}


