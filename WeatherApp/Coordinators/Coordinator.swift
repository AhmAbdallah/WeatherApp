//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

protocol Coordinator {
  var navigationController: UINavigationController { get set }
  func start()
}
