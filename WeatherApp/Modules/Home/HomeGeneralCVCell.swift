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
}
