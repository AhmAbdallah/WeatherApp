//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 9.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class MainCoordinator {
  var window: UIWindow?
  init(window: UIWindow?) {
    self.window = window
  }
  func start() {
    if let userDefaults = UserDefaults.standard.object(forKey: "CitiesArray"), let citiesArray = userDefaults as? [City], citiesArray.count > 0 {
    } else {
      let tabBar = MainTabBarC()
      window?.rootViewController = tabBar
      window?.makeKeyAndVisible()
    }
  }
}
