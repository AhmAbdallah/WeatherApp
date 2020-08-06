//
//  MainTabBarC.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class MainTabBarC: BubbleTabBarController {
  var homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
  var citiesCoordinator = CitiesCoordinator(navigationController: UINavigationController())
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
}

// MARK: MainTabBar
extension MainTabBarC {
  private func setupUI() {
    tabBar.tintColor = .purplyBlue
    tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: R.font.robotoBold(size: 15) as Any], for: .normal)
    tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: R.font.robotoBold(size: 15) as Any], for: .selected)
    if let view = TabBarCustomView.instanceFromNib() as? TabBarCustomView {
      if #available(iOS 13, *) {
        let appearance = self.tabBar.standardAppearance.copy()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        self.tabBar.standardAppearance = appearance
      } else {
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
      }
      tabBar.addSubview(view)
      tabBar.sendSubviewToBack(view)
    }
    tabBar.shadowColor = .clear
    self.view.backgroundColor = .white
    //SetUp tabs
    homeCoordinator.start()
    citiesCoordinator.start()
    viewControllers = [homeCoordinator.navigationController,
                       citiesCoordinator.navigationController]
  }
}
