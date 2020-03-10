//
//  Location.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import Foundation
import UIKit

class Location {
    let latitude: Double
    let longitude: Double
    let date: Date
    let dateString: String
    let description: String
    var weekReports: [Location] = []

    init(latitude: Double, longitude: Double, date: Date, description: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
//        self.dateString = dateString
        self.description = description
    }
}
