//
//  Resource.swift
//  Umbrella
//
//  Created by MCS on 9/5/17.
//  Copyright © 2017 com.mobileconsultingsolutions. All rights reserved.
//

import Foundation

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return json.flatMap(parseJSON)
        }
    }
}
