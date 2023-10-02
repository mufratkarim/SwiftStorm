//
//  WeatherModel.swift
//  SwiftStorm
//
//  Created by Mufrat Karim Aritra on 10/1/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let cityName: String
    let conditionId: Int
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        switch conditionId {
        case 200...202: return "cloud.bolt.rain"
        case 202...221: return "cloud.bolt.fill"
        case 221...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...632: return "cloud.snow"
        case 701...781: return "cloud.fog"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
