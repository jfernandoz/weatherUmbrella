//
//  TabBarController.swift
//  weather
//
//  Created by MCS on 9/6/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        WebService().load(Location.get(zipCode: "78041")) { result in
//            print(result ?? "")
//        }
//        
//        WebService().load(HourlyWeather.get(shortState: "CA", city: "San_Francisco")) { result in
//            print(result ?? "")
//        }

//        WebService().load(DailyWeather.get(shortState: "CA", city: "San_Francisco")) { result in
//            print(result ?? "")
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
