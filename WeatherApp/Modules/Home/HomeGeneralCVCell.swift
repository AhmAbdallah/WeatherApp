//
//  HomeGeneralCVCell.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 3.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class HomeGeneralCVCell: UICollectionViewCell {
  static let identifier = "HomeGeneralCVCell"
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var tempLBL: UILabel!
  @IBOutlet weak var weatherDescriptionLBL: UILabel!
  @IBOutlet weak var dateLBL: UILabel!
  @IBOutlet weak var tempMinLBL: UILabel!
  @IBOutlet weak var tempMaxLBL: UILabel!
  var cityWeatherModel: CityWeatherModel? {
    didSet {
      tempLBL.text = String(format: "%.0f", cityWeatherModel?.mainWeather.temp.rounded() ?? 0) + "°C"
      weatherDescriptionLBL.text = cityWeatherModel?.weather[0].descriptionField
      let inputFormatter = DateFormatter()
      inputFormatter.dateFormat = "dd/MM/yyyy"
      let day = inputFormatter.string(from: Date(timeIntervalSince1970: cityWeatherModel!.timeDataForecasted))
      dateLBL.text = day
      tempMinLBL.text = String(format: "%.0f", cityWeatherModel?.mainWeather.tempMin.rounded() ?? 0) + "°"
      tempMaxLBL.text = String(format: "%.0f", cityWeatherModel?.mainWeather.tempMax.rounded() ?? 0) + "°"
    }
  }
}
