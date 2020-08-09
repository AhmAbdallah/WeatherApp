//
//  AddNewCityCVCell.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 5.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

protocol AddNewCityTVCellDelegate: AnyObject {
  func addCityWith(city: City?)
}
class AddNewCityTVCell: UITableViewCell {
static let identifier = "AddNewCityTVCell"
  
  @IBOutlet weak var cityLBL: UILabel!
  
  weak var addNewCityTVCellDelegate: AddNewCityTVCellDelegate?
  
  var city: City? {
    didSet {
      if let city = city {
        cityLBL.text = city.name
      }
    }
  }
  
  @IBAction func tapAddingCityBTN(_ sender: Any) {
    addNewCityTVCellDelegate?.addCityWith(city: city)
  }
}
