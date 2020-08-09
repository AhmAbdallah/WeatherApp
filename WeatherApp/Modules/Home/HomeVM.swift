//
//  HomeVM.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HomeVMDelegate: AnyObject {
  func updateUI()
}
class HomeVM {
  weak var homeVMDelegate: HomeVMDelegate?
  weak var viewControllerDelegate: ViewControllerDelegate?
  var cityWeatherModel: CityWeatherModel?
  var weeklyModel: WeeklyModel?
  init() {
    weeklyModel = getDataFromLocal()
  }
}

extension HomeVM {
  func getWeatherDataFor(cityId: String) {
    let paramArray: [String: Any] = ["id": cityId,
                                     "appid": "38cb0107cf99d66e5588cc7cf2aa722a",
                                     "lang": "tr"]
    callWebServiceWith(param: paramArray)
  }
  func callWebServiceWith(param: [String: Any]) {
    self.viewControllerDelegate?.vMShowProgressLoading()
    ServiceConnector.shared.connect(.getCityWeather(params: param), success: { (target, response, statusCode) in
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
      self.cityWeatherModel = CityWeatherModel(fromJson: response)
      self.viewControllerDelegate?.vMHideProgressLoading()
      self.homeVMDelegate?.updateUI()
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

extension HomeVM {
  func getDataFromLocal() -> WeeklyModel? {
    if let path = Bundle.main.path(forResource: "weekly", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        guard let personArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        let json = JSON(personArray)
        let weeklyModel = WeeklyModel(fromJson: json)
        return weeklyModel
      } catch {
        print(error)
      }
    }
    return nil
  }
}
