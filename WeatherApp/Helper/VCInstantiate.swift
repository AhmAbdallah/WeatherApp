//
//  VCInstantiate.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

protocol VCInstantiate {
  static func instantiate(_ storyboardName: String) -> Self
}

// MARK: VCInstantiate
extension VCInstantiate where Self: UIViewController {
  static func instantiate(_ storyboardName: String = "Main") -> Self {
    var stringId: String {
      return String(describing: Self.self)
    }
    var storyboard: UIStoryboard {
      return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    var viewController: UIViewController {
      return storyboard.instantiateViewController(withIdentifier: stringId)
    }
    return viewController as! Self // swiftlint:disable:this force_cast
  }
}
