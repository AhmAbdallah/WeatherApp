//
//  CustomLaunchScreenVC.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 8.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class CustomLaunchScreenVC: UIViewController, VCInstantiate {
  var window: UIWindow?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let userDefaults = UserDefaults.standard.object(forKey: "CitiesArray"), let citiesArray = userDefaults as? [City], citiesArray.count > 0 {
    } else {
      let tabBar = MainTabBarC()
      window?.rootViewController = nil
      window?.rootViewController = tabBar
      window?.makeKeyAndVisible()
    }
  }
}
