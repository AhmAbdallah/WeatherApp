//
//  CitiesModel.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 7.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation
import SwiftyJSON

class CitiesModel: NSObject {
  var citiesGroup: [CityGroup]!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    citiesGroup = [CityGroup]()
    let cityGroupArray = json["cityGroup"].arrayValue
    for cityGroupJson in cityGroupArray {
      let value = CityGroup(fromJson: cityGroupJson)
      citiesGroup.append(value)
    }
  }
}

class CityGroup: NSObject {
  var cities: [City]!
  var groupTitle: String!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    cities = [City]()
    let citiesArray = json["cities"].arrayValue
    for citiesJson in citiesArray {
      let value = City(fromJson: citiesJson)
      cities.append(value)
    }
    groupTitle = json["groupTitle"].stringValue
  }
}
class City: NSObject {
  var coord: Coordinates!
  var country: String!
  var cityId: Int!
  var name: String!
  var state: String!
  var selected: Bool!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    let coordJson = json["coord"]
    if !coordJson.isEmpty {
      coord = Coordinates(fromJson: coordJson)
    }
    country = json["country"].stringValue
    cityId = json["id"].intValue
    name = json["name"].stringValue
    state = json["state"].stringValue
    selected = false
  }
}
