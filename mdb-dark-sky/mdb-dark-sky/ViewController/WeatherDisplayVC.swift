//
//  WeatherDisplayVC.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/8/20.
//  Copyright © 2020 James Jung. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation
import AVFoundation

class WeatherDisplayVC: UIViewController {
    let locationManager = CLLocationManager()
    var currWeekWeathers: [Weather] = [] // tableview -> seven weathers
    var currWeather: Weather!        // collectionview -> currweather details
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    var urlkey = "https://api.darksky.net/forecast/64976a352d42a63e1843c54a2626a59a/"
    var defaultUrl: String!
    var DateString: String?
    var isSearching = false
    
    @IBOutlet weak var CurrLocation: UILabel!
    @IBOutlet weak var CurrTemp: UILabel!
    @IBOutlet weak var CurrDay: UILabel!
    @IBOutlet weak var CurrHiTemp: UILabel!
    @IBOutlet weak var CurrLoTemp: UILabel!
    @IBOutlet weak var CurrSummary: UILabel!
    @IBOutlet weak var PoP: UILabel!
    @IBOutlet weak var PrecipType: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var FeelsLike: UILabel!
    
    
    @IBOutlet weak var thisWeekTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        determineCurrentLocation()
        //updateBackgroundGIF()
        thisWeekTable.backgroundColor = UIColor.clear
    }
    
    @IBAction func comingFromSearchUnWindSegue(segue: UIStoryboardSegue) {
        print("COORDS FROM SEARCH: \(latitude), \(longitude)")
        determineCurrentLocation()
        thisWeekTable.backgroundColor = UIColor.clear
    }
    
    func updateBackgroundGIF() {
        let filePath = Bundle.main.path(forResource: "sfSky", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        
        let webViewBG = UIWebView(frame: self.view.frame)
        webViewBG.load(gif! as Data, mimeType: "image/gif", textEncodingName: String(), baseURL: URL(fileReferenceLiteralResourceName: "sfSky.gif"))
        webViewBG.isUserInteractionEnabled = false;
        self.view.addSubview(webViewBG)
        
        // for UI
        let filter = UIView()
        filter.frame = self.view.frame
        filter.backgroundColor = UIColor.black
        filter.alpha = 0.05
        self.view.addSubview(filter)
    }
    
    func updateCurrWeather() {
        // get city name
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            
            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Errorz"
                print("unable to get geocode: \(errorString)")
                return
            }
            
            self.CurrLocation.text = placemark.locality!
        }
        self.CurrTemp.text = "\(Int(currWeather.temperature!))º"
        let date = APIManager.getDate(unix: currWeather.time)
        self.CurrDay.text = APIManager.getDayOfWeek(date)!
        self.CurrHiTemp.text = "\(Int(currWeather.temperatureHigh ?? 65))"
        self.CurrLoTemp.text = "\(Int(currWeather.temperatureLow ?? 45))"
        self.CurrSummary.text = "Today: \(currWeather.summary)"
        self.PoP.text = "\(Int(currWeather.precipProbability * 10))%"
        self.PrecipType.text = "\(currWeather.precipType ?? "None")"
        self.WindSpeed.text = "\(currWeather.windSpeed) mph"
        self.FeelsLike.text = "\(Int(currWeather.apparentTemperature!))º"
    }
    @IBAction func playAudioForecast(_ sender: Any) {
        var forecastString: String?
        forecastString = "Currently in \(self.CurrLocation.text!) \(self.CurrDay.text!) it is \(currWeather.temperature!) degrees and \(currWeather.summary). The high for today is \(currWeather.temperatureHigh ?? 65) degrees with \(currWeather.temperatureLow ?? 45) being the lowest for today. There is a \(currWeather.precipProbability * 10) percent chance of \(currWeather.precipType ?? "rain") with an apparent temperature of \(currWeather.apparentTemperature!) degrees. Current Wind speed is \(currWeather.windSpeed) miles per hour so expect a small breeze on your way out today. Have a great day!"
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: forecastString!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        synthesizer.speak(utterance)
    }
}
