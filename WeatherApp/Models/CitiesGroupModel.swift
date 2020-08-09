//
//  CitiesGroupModel.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 9.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation
import SwiftyJSON

class CitiesGroupModel: NSObject {
  var cnt: Int!
  var list: [List]!
  
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    cnt = json["cnt"].intValue
    list = [List]()
    let listArray = json["list"].arrayValue
    for listJson in listArray {
      let value = List(fromJson: listJson)
      list.append(value)
    }
  }
}

class List: NSObject {
  var clouds: Cloud!
  var coord: Coordinates!
  var listDT: Double!
  var listID: Int!
  var main: MainWeather!
  var name: String!
  var sys: CounrtySYS!
  var visibility: Int!
  var weather: [Weather]!
  var wind: Wind!
  
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    let cloudsJson = json["clouds"]
    if !cloudsJson.isEmpty {
      clouds = Cloud(fromJson: cloudsJson)
    }
    let coordJson = json["coord"]
    if !coordJson.isEmpty {
      coord = Coordinates(fromJson: coordJson)
    }
    listDT = json["dt"].doubleValue
    listID = json["id"].intValue
    let mainJson = json["main"]
    if !mainJson.isEmpty {
      main = MainWeather(fromJson: mainJson)
    }
    name = json["name"].stringValue
    let sysJson = json["sys"]
    if !sysJson.isEmpty {
      sys = CounrtySYS(fromJson: sysJson)
    }
    visibility = json["visibility"].intValue
    weather = [Weather]()
    let weatherArray = json["weather"].arrayValue
    for weatherJson in weatherArray {
      let value = Weather(fromJson: weatherJson)
      weather.append(value)
    }
    let windJson = json["wind"]
    if !windJson.isEmpty {
      wind = Wind(fromJson: windJson)
    }
  }
}
