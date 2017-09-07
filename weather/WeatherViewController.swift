//
//  WeatherViewController.swift
//  weather
//
//  Created by MCS on 9/6/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    var dailyWeather: DailyWeather!
    var hourlyWeather: [HourlyWeather]!
    var location: Location!
    var days = ["Today", "Tomorrow"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dayAfterTomorrow = Calendar.current.date(byAdding: Calendar.Component.day, value: 2, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dateFormatter.string(from: dayAfterTomorrow!)
        days.append(dayOfWeekString)
    }

    override func viewWillAppear(_ animated: Bool) {
        loadAPI()
    }
    
    func loadAPI() {
        WebService().load(Location.get(zipCode: "30030")) { result in
            guard let location = result?[0] else { return }
            self.location = location
            self.loadDailyWeather()
            self.loadHourlyWeather()
        }
    }
    
    func loadDailyWeather() {
        WebService().load(DailyWeather.get(shortState: location.shortState, city: location.city.replacingOccurrences(of: " ", with: "_"))) { result in
            guard let dailyWeather = result?[0] else { return }
            self.dailyWeather = dailyWeather
            DispatchQueue.main.async {
                self.updateDailyView()
            }
        }
    }
    
    func updateDailyView() {
        tempLbl.text = dailyWeather.celsiusH
        statusLbl.text = dailyWeather.conditions
        cityLbl.text = location.city
        
        if Int(dailyWeather.celsiusH)! > 20 {
            contentView.backgroundColor = UIColor(colorLiteralRed: 243/255, green: 151/255, blue: 49/255, alpha: 1)
        } else {
            contentView.backgroundColor = UIColor(colorLiteralRed: 57/255, green: 169/255, blue: 244/255, alpha: 1)
        }
        
    }
    
    func loadHourlyWeather() {
        WebService().load(HourlyWeather.get(shortState: location.shortState, city: location.city.replacingOccurrences(of: " ", with: "_"))){ result in
            guard let hourlyWeather = result else { return }
            self.hourlyWeather = hourlyWeather
            print(hourlyWeather)
            DispatchQueue.main.async {
                self.updateHourlyView()
            }
        }
    }
    
    func updateHourlyView() {
        
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

extension WeatherViewController: UITableViewDelegate {
    
}

extension WeatherViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section]
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
