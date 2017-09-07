//
//  DailyWeather.swift
//  weather
//
//  Created by MCS on 9/6/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

struct DailyWeather {
    let uxTimestamp: String
    let weekday: String
    let conditions: String
    let celsiusH: String
    let fahrenheitH: String
    let celsiusL: String
    let fahrenheitL: String
}

extension DailyWeather {
    init?(dictionary: JSONDictionary) {
        guard let uxTimestamp = (dictionary["date"] as? JSONDictionary)?["epoch"] as? String,
            let weekday = (dictionary["date"] as? JSONDictionary)?["weekday"] as? String,
            let highCelsius = (dictionary["high"] as? JSONDictionary)?["celsius"] as? String,
            let highFahrenheit = (dictionary["high"] as? JSONDictionary)?["fahrenheit"] as? String,
            let lowCelsius = (dictionary["low"] as? JSONDictionary)?["celsius"] as? String,
            let lowFahrenheit = (dictionary["low"] as? JSONDictionary)?["fahrenheit"] as? String,
            let conditions = dictionary["conditions"] as? String else { return nil }
        self.uxTimestamp = uxTimestamp
        self.weekday = weekday
        self.celsiusH = highCelsius
        self.celsiusL = lowCelsius
        self.fahrenheitH = highFahrenheit
        self.fahrenheitL = lowFahrenheit
        self.conditions = conditions
    }
    
}

extension DailyWeather {
    static func get(shortState: String, city: String) -> Resource<[DailyWeather]> {
        let urlString = "\(Settings.endpoints.baseWeather)\(Settings.endpoints.forecast)\(shortState)/\(city).json"
        let result = Resource<[DailyWeather]>(url: URL(string: urlString)!, parseJSON: { json in
            guard let dictionary = json as? JSONDictionary,
                let forecast = dictionary["forecast"] as? JSONDictionary,
                let simpleForecast = forecast["simpleforecast"] as? JSONDictionary,
                let dailyForecast = simpleForecast["forecastday"] as? [JSONDictionary] else { return nil }
            return dailyForecast.flatMap(DailyWeather.init)
        })
        return result
    }
}
