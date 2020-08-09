//
//  HomeWeeklyWeatherCVCell.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 4.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class HomeWeeklyWeatherCVCell: UICollectionViewCell {
  static let identifier = "HomeWeeklyWeatherCVCell"
  @IBOutlet weak var stackView: UIStackView!
  var data: [WeeklyData]? {
    didSet {
      self.stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
      for weeklyData in data! {
        if let view = WeeklyWeatherView.instanceFromNib() as? WeeklyWeatherView {
          self.stackView.addArrangedSubview(view)
          view.dayLBL.text = weeklyData.day
          view.imageView.image = UIImage(named: weeklyData.image)
          view.maxLBL.text = "\(weeklyData.maxDegree ?? 0)°"
          view.minLBL.text = "\(weeklyData.minDegree ?? 0)°"
        }
      }
    }
  }
}
