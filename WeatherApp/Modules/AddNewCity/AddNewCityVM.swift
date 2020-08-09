//
//  AddNewCity.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 5.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol  AddNewCityVMDelegate: AnyObject {
  func openHomePage()
  func showInfo(message: String)
}
class AddNewCityVM {
  weak var addNewCityVMDelegate: AddNewCityVMDelegate?
  weak var viewControllerDelegate: ViewControllerDelegate?
  var citiesModel: CitiesModel?
  init() {
    citiesModel = getDataFromLocal()
  }
}

extension AddNewCityVM {
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

extension AddNewCityVM {
  func getSectionCount() -> Int {
    if let count = citiesModel?.citiesGroup.count {
      return count
    }
    return 0
  }
  
  func getTitleFor(section: Int) -> String {
    if let title = citiesModel?.citiesGroup[section].groupTitle {
      return title
    }
    return ""
  }
  
  func getSectionIndexTitles() -> [String] {
    if let titlesArray = citiesModel?.citiesGroup.map({$0.groupTitle}) as? [String] {
      return titlesArray
    }
    return []
  }
  
  func getRowCountFor(section: Int) -> Int {
    if let count = citiesModel?.citiesGroup[section].cities.count {
      return count
    }
    return 0
  }
  
  func getTitleFor(section: Int, row: Int) -> String {
    if let title = citiesModel?.citiesGroup[section].cities[row].name {
      return title
    }
    return ""
  }
  
  func getCityFor(section: Int, row: Int) -> City? {
    if let city = citiesModel?.citiesGroup[section].cities[row] {
      return city
    }
    return nil
  }
  
  func addCityWith(city: City?, isAddingMode: Bool) {
    if let citiesArray = WeatherAppSessionManager.shared.citiesArray, citiesArray.count > 0 {
      if (citiesArray.first(where: { $0.cityId == city?.cityId }) != nil) {
        viewControllerDelegate?.returnErrorWith("başka bir şehir ekler misiniz")
      } else {
        var array: [City] = citiesArray
        array.append(city!)
        WeatherAppSessionManager.shared.citiesArray = array
        if !isAddingMode {
          if array.count > 2 {
            addNewCityVMDelegate?.openHomePage()
          }
        }
        addNewCityVMDelegate?.showInfo(message: "şehir ekledi")
      }
    } else {
      let array: [City] = [city!]
      WeatherAppSessionManager.shared.citiesArray = array
      addNewCityVMDelegate?.showInfo(message: "şehir ekledi")
    }
  }
}
