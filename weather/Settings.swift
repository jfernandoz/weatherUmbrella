//
//  Settings.swift
//  weather
//
//  Created by MCS on 9/6/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation
typealias JSONDictionary = [String: AnyObject]

struct Settings {
    struct endpoints {
        static let google = "https://maps.googleapis.com/maps/api/geocode/json?address="
        static let baseWeather = "https://api.wunderground.com/api/bbd695f33992718f/"
        static let hourly = "hourly/q/"
        static let forecast = "forecast/q/"
    }
    
    static let colorChangeCelsius = 20
    
    static let defaultZip = "30030"
    
    static func convert(temp: Double) -> String {
        let measurement = Measurement.init(value: temp, unit: UnitTemperature.celsius)
        let mf = MeasurementFormatter()
        return mf.string(from: measurement)
    }
}
