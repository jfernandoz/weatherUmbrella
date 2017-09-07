//
//  WebService.swift
//  Umbrella
//
//  Created by MCS on 9/5/17.
//  Copyright © 2017 com.mobileconsultingsolutions. All rights reserved.
//

import Foundation

final class WebService {
    func load<A>(_ resource: Resource<A>, completion: @escaping (A?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            guard error == nil else {
                print("Error : \(error.debugDescription)")
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            completion(resource.parse(data))
            }.resume()
    }
}
