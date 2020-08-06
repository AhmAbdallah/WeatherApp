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
      let tabBar = MainTabBarC()
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = tabBar
      window?.makeKeyAndVisible()
    }
    return true
  }
}
