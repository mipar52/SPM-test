//
//  WeatherJSON.swift
//  MyWeatherApp
//
//  Created by Milan Parađina on 24.10.2022..
//

import Foundation

struct WeatherJSON: Decodable {
    let location: Location
    let forecasts: [Forecasts]
}

struct Location: Decodable {
    let city: String
    let country: String
    let timezone_id: String
}

struct Forecasts: Decodable {
    let day: String
    let low: Int
    let high: Int
    let text: String
}

