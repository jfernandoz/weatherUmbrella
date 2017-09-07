//
//  DailyWeatherCell.swift
//  weather
//
//  Created by MCS on 9/6/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class DailyWeatherCell: UITableViewCell {

    @IBOutlet weak var hourlyCollection: UICollectionView!
    var hourlyDataSet: [HourlyWeather]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let nib = UINib(nibName: "HourlyWeatherCell", bundle: nil)
        hourlyCollection.register(nib, forCellWithReuseIdentifier: "HourlyWeatherCell")
        hourlyCollection.delegate = self
        hourlyCollection.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DailyWeatherCell: UICollectionViewDelegate {
    
}

extension DailyWeatherCell: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let result = hourlyDataSet?.count else {
            return 0
        }
        return result
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourlyCollection.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCell", for: indexPath) as? HourlyWeatherCell
        if let temp = hourlyDataSet?[indexPath.row].celsius {
            cell?.tempHourlyLbl.text = Settings.convert(temp: Double(temp)!)
        }
        if let image = hourlyDataSet?[indexPath.row].condition {
            cell?.hourlyImage.image = UIImage(named: image.lowercased())
        }
        if let hour = hourlyDataSet?[indexPath.row].hour {
            cell?.hourLbl.text = hour
        }
        return cell!
    }
    
}
