//
//  WeatherHelper.swift
//  MyWeatherApp
//
//  Created by Milan Parađina on 24.10.2022..
//

import Foundation

class WeatherHelper {
    
    func getYahooWeatherData(latitude: String, longitude: String, completion: @escaping (Result<WeatherInformation, WeatherServiceError>) -> Void)  {
        
        let headers = [
            "X-RapidAPI-Key": "a61c914f7amsh1c4bbcfc2bc7210p1c288cjsnc3406007b88e",
            "X-RapidAPI-Host": "yahoo-weather5.p.rapidapi.com"
        ]
        
        guard let url = URL(string: "https://yahoo-weather5.p.rapidapi.com/weather?lat=\(latitude)&long=\(longitude)&format=json&u=c") else {
            completion(.failure(.badUrl))
            return
        }
        
        let request = NSMutableURLRequest(url: url,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(.failure(.timeout))
                print(error?.localizedDescription ?? "Timeout error")
            } else {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherJSON.self, from: data!)
                    
                    let newWeatherInfo = WeatherInformation(city: weatherData.location.city, high: weatherData.forecasts[0].high, low: weatherData.forecasts[0].low, weatherInfo: weatherData.forecasts[0].text)
                    
                    completion(.success(newWeatherInfo))
                } catch {
                    completion(.failure(.incorrectData))
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
}

enum WeatherServiceError : Error {
    case timeout
    case incorrectData
    case badUrl
}
