//
//  WeatherCell.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var DayOfWeek: UILabel!
    @IBOutlet weak var WeatherImg: UIImageView!
    @IBOutlet weak var TempHi: UILabel!
    @IBOutlet weak var TempLow: UILabel!
}
