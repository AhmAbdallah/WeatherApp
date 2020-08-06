//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 3.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    if let windowScene = scene as? UIWindowScene {
      self.window = UIWindow(windowScene: windowScene)
      let tabBar = MainTabBarC()
      self.window!.rootViewController = tabBar
      self.window!.makeKeyAndVisible()
    }
  }
}