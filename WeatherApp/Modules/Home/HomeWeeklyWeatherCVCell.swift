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
  func updateUI() {
    self.stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    for index in 0...6 {
      if let view = WeeklyWeatherView.instanceFromNib() as? WeeklyWeatherView {
        self.stackView.addArrangedSubview(view)
      }
    }
  }
}
