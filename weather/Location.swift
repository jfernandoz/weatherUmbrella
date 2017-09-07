//
//  Location.swift
//  Umbrella
//
//  Created by MCS on 9/5/17.
//  Copyright © 2017 com.mobileconsultingsolutions. All rights reserved.
//

import Foundation

struct Location {
    let city: String
    let shortState: String
}

extension Location {
    init?(dictionary: JSONDictionary) {
        guard let components = (dictionary["address_components"] as? [JSONDictionary]),
            let city = (components[1] as JSONDictionary)["long_name"] as? String,
            let shortState = (components[3] as JSONDictionary)["short_name"] as? String else { return nil }
        self.city = city
        self.shortState = shortState
    }
}

extension Location {
    static func get(zipCode: String) -> Resource<[Location]> {
        let result = Resource<[Location]>(url: URL(string: "\(Settings.endpoints.google)\(zipCode)")!, parseJSON: { json in
            guard let dictionary = json as? JSONDictionary,
                let dictionaries = dictionary["results"] as? [JSONDictionary] else { return nil }
            return dictionaries.flatMap(Location.init)
        })
        return result
    }
}
