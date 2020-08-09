//
//  WeeklyWeatherView.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 4.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class WeeklyWeatherView: UIView {
  @IBOutlet weak var dayLBL: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var maxLBL: UILabel!
  @IBOutlet weak var minLBL: UILabel!
  class func instanceFromNib() -> UIView {
    guard let view =  UINib(nibName: "WeeklyWeatherView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView else { fatalError("Unexpected Index Path") }
    return view
  }
}
