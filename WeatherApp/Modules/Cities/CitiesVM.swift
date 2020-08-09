//
//  CitiesVM.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 4.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol CitiesVMDelegate: AnyObject {
  func updateUI()
  func showAddNewCityVC()
}

class CitiesVM {
  weak var citiesVMDelegate: CitiesVMDelegate?
  weak var viewControllerDelegate: ViewControllerDelegate?
  var citiesGroupModel: CitiesGroupModel?
  init() {
  }
}

extension CitiesVM {
  func getCitiesGroupData() {
    let cities = WeatherAppSessionManager.shared.citiesArray
    if cities?.count == 0 {
      viewControllerDelegate?.returnErrorWith("Henüz şehirleriniz bulunmuyor.")
      return
    }
    var cityIDS = ""
    for city in cities! {
      cityIDS += "\(city.cityId ?? 0),"
    }
    cityIDS.removeLast()
    let paramArray: [String: Any] = ["id": cityIDS,
                                     "appid": "38cb0107cf99d66e5588cc7cf2aa722a",
                                     "lang": "tr"]
    callWebServiceWith(param: paramArray)
  }
  func callWebServiceWith(param: [String: Any]) {
    self.viewControllerDelegate?.vMShowProgressLoading()
    ServiceConnector.shared.connect(.getCitiesGroup(params: param), success: { (target, response, statusCode) in
      print(response)
      self.handelGetWeatherDataFor(response: response, statusCode: statusCode)
    }) { (target, error) in
      print("\(error) ==== \(target)")
      self.viewControllerDelegate?.returnErrorWith("Bir hata oluştu")
      self.viewControllerDelegate?.vMHideProgressLoading()
    }
  }
  
  func handelGetWeatherDataFor(response: JSON, statusCode: Int) {
    if statusCode == 200 {
      self.citiesGroupModel = CitiesGroupModel(fromJson: response)
      self.viewControllerDelegate?.vMHideProgressLoading()
      self.citiesVMDelegate?.updateUI()
    } else {
      self.handleTheErrorFor(response: response)
    }
  }
  
  func handleTheErrorFor(response: JSON) {
    if let message = response["message"].string {
      self.viewControllerDelegate?.returnErrorWith(message)
      self.viewControllerDelegate?.vMHideProgressLoading()
    } else {
      self.viewControllerDelegate?.returnErrorWith("Bir hata oluştu")
      self.viewControllerDelegate?.vMHideProgressLoading()
    }
  }
}

extension CitiesVM {
  func getRowCount() -> Int {
    if let count = citiesGroupModel?.list.count {
      return count
    }
    return 0
  }
  func getTitleFor(row: Int) -> String {
    if let title = citiesGroupModel?.list[row].name {
      return title
    }
    return ""
  }
  func getListFor(row: Int) -> List? {
    if let city = citiesGroupModel?.list[row] {
      return city
    }
    return nil
  }
  func deleteDataFor(row: Int) {
    var cities = WeatherAppSessionManager.shared.citiesArray
    cities?.remove(at: row)
    WeatherAppSessionManager.shared.citiesArray = cities
    citiesGroupModel?.list.remove(at: row)
    if citiesGroupModel?.list.count == 0 {
      citiesVMDelegate?.showAddNewCityVC()
    } else {
      citiesVMDelegate?.updateUI()
    }
  }
}
