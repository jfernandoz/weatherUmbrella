//
//  DailyWeather.swift
//  weather
//
//  Created by MCS on 9/6/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

struct HourlyWeather {
    let day: String
    let hour: String
    let weekday: String
    let celsius: String
    let farenheith: String
    let condition: String
}

extension HourlyWeather {
    init?(dictionary: JSONDictionary) {
        guard let day = (dictionary["FCTTIME"] as? JSONDictionary)?["mday_padded"] as? String,
            let hour = (dictionary["FCTTIME"] as? JSONDictionary)?["civil"] as? String,
            let weekday = (dictionary["FCTTIME"] as? JSONDictionary)?["weekday_name"] as? String,
            let celsius = (dictionary["temp"] as? JSONDictionary)?["metric"] as? String,
            let farenheith = (dictionary["temp"] as? JSONDictionary)?["english"] as? String,
            let condition = dictionary["condition"] as? String else { return nil }
        self.day = day
        self.hour = hour
        self.weekday = weekday
        self.celsius = celsius
        self.farenheith = farenheith
        self.condition = condition
    }
    
}

extension HourlyWeather {
    static func get(shortState: String, city: String) -> Resource<[HourlyWeather]> {
        let urlString = "\(Settings.endpoints.baseWeather)\(Settings.endpoints.hourly)\(shortState)/\(city).json"
        let result = Resource<[HourlyWeather]>(url: URL(string: urlString)!, parseJSON: { json in
            guard let dictionary = json as? JSONDictionary,
                let dictionaries = dictionary["hourly_forecast"] as? [JSONDictionary] else { return nil }
            return dictionaries.flatMap(HourlyWeather.init)
        })
        return result
    }
}




