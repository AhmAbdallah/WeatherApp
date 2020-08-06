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
  @IBOutlet weak var windLBL: UILabel! //mhs/s
  @IBOutlet weak var humidityLBL: UILabel! //%45
  @IBOutlet weak var visibilityLBL: UILabel! //Km
  @IBOutlet weak var cloudsLBL: UILabel!
}
