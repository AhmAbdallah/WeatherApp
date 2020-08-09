//
//  CitiesVM.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 4.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation
import SwiftyJSON

class CitiesVM {
  var citiesModel: CitiesModel?
  init() {
    citiesModel = getDataFromLocal()
  }
}

extension CitiesVM {
  func getDataFromLocal() -> CitiesModel? {
    if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        guard let personArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        let json = JSON(personArray)
        let citiesModel = CitiesModel(fromJson: json)
        return citiesModel
      } catch {
        print(error)
      }
    }
    return nil
  }
}

extension CitiesVM {
//  func getRowCount() -> Int {
//    if let count = citiesModel?.data.count {
//      return count
//    }
//    return 0
//  }
//  func getTitleFor(row: Int) -> String {
//    if let title = citiesModel?.data[row].name {
//      return title
//    }
//    return ""
//  }
//  func getCityFor(row: Int) -> City? {
//    if let city = citiesModel?.data[row] {
//      return city
//    }
//    return nil
//  }
}
