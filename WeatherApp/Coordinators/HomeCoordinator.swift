//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
  var navigationController: UINavigationController
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  func start() {
    openHomeVC()
  }
}

// MARK: HomeCoordinator
extension HomeCoordinator {
  private func openHomeVC() {
    let homeVM = HomeVM()
    let homeVC = HomeVC(homeVM: homeVM)
    homeVM.homeVMDelegate = homeVC
    homeVM.viewControllerDelegate = homeVC
    let citiesArray = WeatherAppSessionManager.shared.citiesArray
    homeVM.getWeatherDataFor(cityId: "\(citiesArray?.count ?? 0 > 0 ? citiesArray?[0].cityId ?? 0 : 0)")
    homeVC.tabBarItem = UITabBarItem(title: "Anasayfa", image: R.image.iconHomeTabBarUnSelected(), tag: 0)
    homeVC.tabBarItem.selectedImage = R.image.iconHomeTabBarSelected()
    navigationController.pushViewController(homeVC, animated: true)
  }
}
