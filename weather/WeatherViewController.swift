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
    @IBOutlet weak var tableView: UITableView!
    var dailyWeather: DailyWeather!
    var hourlyWeather: [HourlyWeather]!
    var location: Location!
    var days = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "DailyWeatherCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DailyWeatherCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAPI()
    }
    
    func loadAPI() {
        WebService().load(Location.get(zipCode: getZip())) { result in
            guard let location = result?[0] else { return }
            self.location = location
            self.loadDailyWeather()
            self.populateDays()
            self.loadHourlyWeather()
        }
    }
    
    func getZip() -> String{
        guard let zip = UserDefaults.standard.string(forKey: "Zip") else {
            return Settings.defaultZip
        }
        return zip
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
        tempLbl.text = Settings.convert(temp: Double(dailyWeather.celsiusH)!)
        statusLbl.text = dailyWeather.conditions
        cityLbl.text = location.city
        if Int(dailyWeather.celsiusH)! > Settings.colorChangeCelsius {
            contentView.backgroundColor = UIColor(colorLiteralRed: 243/255, green: 151/255, blue: 49/255, alpha: 1)
        } else {
            contentView.backgroundColor = UIColor(colorLiteralRed: 57/255, green: 169/255, blue: 244/255, alpha: 1)
        }
    }
    
    func populateDays() {
        days = []
        var date: Date?
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        for i in 0...2 {
            date = Calendar.current.date(byAdding: Calendar.Component.day, value: i, to: Date())
            let dayOfWeekString = df.string(from: date!)
            days.append(dayOfWeekString)
        }
    }
    
    func loadHourlyWeather() {
        WebService().load(HourlyWeather.get(shortState: location.shortState, city: location.city.replacingOccurrences(of: " ", with: "_"))){ result in
            guard let hourlyWeather = result else { return }
            self.hourlyWeather = hourlyWeather
            DispatchQueue.main.async {
                self.updateHourlyView()
            }
        }
    }
    
    func updateHourlyView() {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension WeatherViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell") as? DailyWeatherCell
        cell?.hourlyDataSet = hourlyWeather.filter{$0.weekday.contains(days[indexPath.section])}
        return cell!
    }
}


