//
//  ViewController.swift
//  SwiftStorm
//
//  Created by Mufrat Aritra on 01/09/2022.
//  Copyright © 2023 MKA. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextfield: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextfield.delegate = self
    }
    
    @IBAction func pressingCurrentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}
//MARK: CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: long)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func pressingSearchButton(_ sender: UIButton) {
        searchTextfield.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something!"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use weather to display the change using textfield
        if let currentCity = textField.text {
            weatherManager.fetchWeather(currentCity)
        }
        textField.text = ""
    }
    
}
//MARK: WeatherManagerDelegate
extension WeatherViewController: WeatherManagerProtocol{
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didError(_ error: Error) {
        print(error)
    }
}

