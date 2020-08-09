//
//  HomeDailyWeatherCVCell.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 4.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class HomeDailyWeatherCVCell: UICollectionViewCell {
    static let identifier = "HomeDailyWeatherCVCell"
  @IBOutlet weak var windLBL: UILabel!
  @IBOutlet weak var humidityLBL: UILabel!
  @IBOutlet weak var visibilityLBL: UILabel!
  @IBOutlet weak var cloudsLBL: UILabel!
  var cityWeatherModel: CityWeatherModel? {
    didSet {
      windLBL.text = String(format: "%.2f", cityWeatherModel?.wind.speed ?? 0) + " mhs/s"
      humidityLBL.text = "%" + String(format: "%i", cityWeatherModel?.mainWeather.humidity ?? 0)
      let visibility = cityWeatherModel!.visibility / 1000
      visibilityLBL.text = String(format: "%i", visibility) + " km"
      cloudsLBL.text = String(format: "%i", cityWeatherModel?.clouds.all ?? 0)
    }
  }
}
