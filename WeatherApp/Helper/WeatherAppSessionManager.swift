//
//  WeatherAppSessionManager.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 9.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation

class WeatherAppSessionManager {
  static let shared = WeatherAppSessionManager()
  
  var citiesArray: [City]? {
    willSet(newValue) {
      if newValue != nil {
        self.citiesArray = newValue
      } else {
        self.citiesArray = nil
      }
    }
  }
}
