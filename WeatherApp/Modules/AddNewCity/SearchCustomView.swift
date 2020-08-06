//
//  SearchCustomView.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 5.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class SearchCustomView: UIView {
  class func instanceFromNib() -> UIView {
    guard let view =  UINib(nibName: "SearchCustomView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView else { fatalError("Unexpected Index Path") }
    return view
  }
}
