//
//  CitiesCoordinator.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 3.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class CitiesCoordinator: Coordinator {
  var navigationController: UINavigationController
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  func start() {
    openHomeVC()
  }
}

// MARK: CitiesCoordinator
extension CitiesCoordinator {
  private func openHomeVC() {
    let citiesVM = CitiesVM()
    let citiesVC = CitiesVC(citiesVM: citiesVM)
    citiesVC.citiesCoordinator = self
    citiesVC.tabBarItem = UITabBarItem(title: "Şehirler", image: R.image.iconCitiesTabBarUnSelected(), tag: 0)
    citiesVC.tabBarItem.selectedImage = R.image.iconCitiesTabBarSelected()
    navigationController.pushViewController(citiesVC, animated: true)
  }
  func openAddNewCityVC() {
    let addNewCityVM = AddNewCityVM()
    let addNewCityVC = AddNewCityVC(addNewCityVM: addNewCityVM)
    let addNewCityNavigationController = UINavigationController(rootViewController: addNewCityVC)
    addNewCityNavigationController.modalPresentationStyle = .fullScreen
    navigationController.presentDetail(addNewCityNavigationController)
  }
}
