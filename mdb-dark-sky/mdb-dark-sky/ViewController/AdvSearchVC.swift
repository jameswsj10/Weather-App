//
//  AdvSearchVC.swift
//  mdb-dark-sky
//
//  Created by James Jung on 3/9/20.
//  Copyright © 2020 James Jung. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AdvSearchVC: UIViewController {
    var DateString: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func searchButton(_ sender: Any) {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        let date = dateFormatter.date(from: selectedDate)
        let unix = Int(date!.timeIntervalSince1970)
        DateString = String(unix)
        print("THIS IS THE DATESTRING CONTENT: \(DateString)")
        
        if locationTxtField.text != "" {
            getCoordinateFrom(address: locationTxtField.text!) { coordinate, error in
                if let coordinate = coordinate, error == nil {
                    self.latitude = coordinate.latitude
                    self.longitude = coordinate.longitude
                    
                    guard let destVC = self.navigationController?.viewControllers[0] as! WeatherDisplayVC? else { return }
                    destVC.latitude = self.latitude
                    destVC.longitude = self.longitude
                    destVC.DateString = self.DateString
                    self.performSegue(withIdentifier: "loadUpSearchedWeather", sender: Any?.self)
                } else {
                    self.displayAlert("Please enter a valid location")
                    return
                }
            }
        } else {
            guard let destVC = self.navigationController?.viewControllers[0] as! WeatherDisplayVC? else{
                return
            }
            destVC.latitude = nil
            destVC.longitude = nil
            destVC.DateString = self.DateString
            self.performSegue(withIdentifier: "loadUpSearchedWeather", sender: Any?.self)
        }
        
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
           CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
       }
    
    func displayAlert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDisplayVC {
            destinationVC.DateString = DateString
            if locationTxtField != nil {
                print("curr destVC long: \(destinationVC.longitude) lat: \(destinationVC.latitude)")
                print("updating values of long: \(longitude) lat: \(latitude)")
                destinationVC.longitude = longitude
                destinationVC.latitude = latitude
            }
            destinationVC.isSearching = true
            destinationVC.modalPresentationStyle = .fullScreen
        }
    }
}
