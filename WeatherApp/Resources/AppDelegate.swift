//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    //IQKeyboardManager
    IQKeyboardManager.shared.enable = true
    if #available(iOS 13.0, *) { } else {
      checkTheView()
    }
    return true
  }
}
extension AppDelegate {
  func checkTheView() {
    if let citiesArray = WeatherAppSessionManager.shared.citiesArray, citiesArray.count > 0 {
      let tabBar = MainTabBarC()
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = tabBar
      window?.makeKeyAndVisible()
    } else {
      let addNewCityVM = AddNewCityVM()
      let addNewCityVC = AddNewCityVC(addNewCityVM: addNewCityVM)
      addNewCityVC.isAddingMode = false
      let addNewCityNavigationController = UINavigationController(rootViewController: addNewCityVC)
      addNewCityNavigationController.modalPresentationStyle = .fullScreen
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = addNewCityNavigationController
      window?.makeKeyAndVisible()
    }
  }
}
