//
//  WeatherManager.swift
//  SwiftStorm
//
//  Created by Mufrat Karim Aritra on 10/1/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerProtocol {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModel)
    func didError(_ error: Error)
}

struct WeatherManager{
    var weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=303c40269e562e4013a8332819acab2d&units=metric"
    var delegate: WeatherManagerProtocol?
    
    func fetchWeather(_ cityName: String) {
        let weatherString = "\(weatherUrl)&q=\(cityName)"
        executeRequest(weatherString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let weatherString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        executeRequest(weatherString)
    }
    
    
    func executeRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, err in
                if err != nil {
                    delegate?.didError(err!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoderObject = try decoder.decode(WeatherData.self, from: data)
            let id = decoderObject.weather[0].id
            let name = decoderObject.name
            let temp = decoderObject.main.temp
            return WeatherModel(cityName: name, conditionId: id, temperature: temp)
            
        } catch {
            delegate?.didError(error)
            return nil
        }
        
    }
    
    
}
