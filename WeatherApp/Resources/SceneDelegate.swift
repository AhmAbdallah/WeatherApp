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
    guard ((scene as? UIWindowScene) != nil) else { return }
    if let windowScene = scene as? UIWindowScene {
      checkTheView(windowScene: windowScene)
    }
  }
}

@available(iOS 13.0, *)
extension SceneDelegate {
  func checkTheView(windowScene: UIWindowScene) {
    if let citiesArray = WeatherAppSessionManager.shared.citiesArray, citiesArray.count > 0 {
      self.window = UIWindow(windowScene: windowScene)
      let tabBar = MainTabBarC()
      self.window!.rootViewController = tabBar
      self.window!.makeKeyAndVisible()
    } else {
      let addNewCityVM = AddNewCityVM()
      let addNewCityVC = AddNewCityVC(addNewCityVM: addNewCityVM)
      addNewCityVM.addNewCityVMDelegate = addNewCityVC
      addNewCityVM.viewControllerDelegate = addNewCityVC
      addNewCityVC.isAddingMode = false
      let addNewCityNavigationController = UINavigationController(rootViewController: addNewCityVC)
      addNewCityNavigationController.modalPresentationStyle = .fullScreen
      window = UIWindow(windowScene: windowScene)
      window?.rootViewController = addNewCityNavigationController
      window?.makeKeyAndVisible()
    }
  }
}
