//
//  WeatherData.swift
//  SwiftStorm
//
//  Created by Mufrat Aritra on 01/09/2022.
//  Copyright © 2023 Lego Code. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable{
    let description: String
    let id: Int
}
