//
//  CityWeatherModel.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 6.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityWeatherModel: NSObject {
  var base: String!
  var clouds: Cloud!
  var cod: Int!
  var coord: Coordinates!
  var timeDataForecasted: Double!
  var cityId: Int!
  var mainWeather: MainWeather!
  var name: String!
  var sys: CounrtySYS!
  var timezone: Int!
  var visibility: Int!
  var weather: [Weather]!
  var wind: Wind!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    base = json["base"].stringValue
    let cloudsJson = json["clouds"]
    if !cloudsJson.isEmpty {
      clouds = Cloud(fromJson: cloudsJson)
    }
    cod = json["cod"].intValue
    let coordJson = json["coord"]
    if !coordJson.isEmpty {
      coord = Coordinates(fromJson: coordJson)
    }
    timeDataForecasted = json["dt"].doubleValue
    cityId = json["id"].intValue
    let mainJson = json["main"]
    if !mainJson.isEmpty {
      mainWeather = MainWeather(fromJson: mainJson)
    }
    name = json["name"].stringValue
    let sysJson = json["sys"]
    if !sysJson.isEmpty {
      sys = CounrtySYS(fromJson: sysJson)
    }
    timezone = json["timezone"].intValue
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

class Wind: NSObject {
  var deg: Int!
  var speed: Float!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    deg = json["deg"].intValue
    speed = json["speed"].floatValue
  }
}

class Weather: NSObject {
  var descriptionField: String!
  var icon: String!
  var weatherId: Int!
  var main: String!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    descriptionField = json["description"].stringValue
    icon = json["icon"].stringValue
    weatherId = json["id"].intValue
    main = json["main"].stringValue
  }
}

class CounrtySYS: NSObject {
  var country: String!
  var sunrise: Int!
  var sunset: Int!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    country = json["country"].stringValue
    sunrise = json["sunrise"].intValue
    sunset = json["sunset"].intValue
  }
}

class MainWeather: NSObject {
  var feelsLike: Float!
  var grndLevel: Int!
  var humidity: Int!
  var pressure: Int!
  var seaLevel: Int!
  var temp: Float!
  var tempMax: Float!
  var tempMin: Float!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    feelsLike = json["feels_like"].floatValue
    grndLevel = json["grnd_level"].intValue
    humidity = json["humidity"].intValue
    pressure = json["pressure"].intValue
    seaLevel = json["sea_level"].intValue
    temp = json["temp"].floatValue
    temp -= 273.15
    tempMax = json["temp_max"].floatValue
    tempMax -= 273.15
    tempMin = json["temp_min"].floatValue
    tempMin -= 273.15
  }
}

class Coordinates: NSObject {
  var lat: Float!
  var lon: Float!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    lat = json["lat"].floatValue
    lon = json["lon"].floatValue
  }
}

class Cloud: NSObject {
  var all: Int!
  init(fromJson json: JSON!) {
    if json.isEmpty {
      return
    }
    all = json["all"].intValue
  }
}
