//
//  WeeklyModel.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 6.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeeklyModel: NSObject {
  var data: [WeeklyData]!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    data = [WeeklyData]()
    let dataArray = json["data"].arrayValue
    for dataJson in dataArray {
      let value = WeeklyData(fromJson: dataJson)
      data.append(value)
    }
  }
}
class WeeklyData: NSObject {
  var day: String!
  var weeklyDataId: Int!
  var image: String!
  var maxDegree: Int!
  var minDegree: Int!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    day = json["day"].stringValue
    weeklyDataId = json["id"].intValue
    image = json["image"].stringValue
    maxDegree = json["maxDegree"].intValue
    minDegree = json["minDegree"].intValue
  }
}
