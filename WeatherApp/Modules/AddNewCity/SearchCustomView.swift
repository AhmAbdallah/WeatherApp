//
//  SearchCustomView.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 5.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

protocol SearchCustomViewDelegate: AnyObject {
  func dismissAddNewCityVC()
  func updateTheVCWith(text: String)
}
class SearchCustomView: UIView {
  weak var searchCustomViewDelegate: SearchCustomViewDelegate?
  
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var backBTNViewConstriant: NSLayoutConstraint!
  
  var isAddingMode: Bool? {
    didSet {
      if isAddingMode! {
        backBTNViewConstriant.constant = 42
      } else {
        backBTNViewConstriant.constant = 0
      }
    }
  }
  class func instanceFromNib() -> UIView {
    guard let view =  UINib(nibName: "SearchCustomView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView else { fatalError("Unexpected Index Path") }
    return view
  }
  
  func setupUI() {
    searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
  }
  @objc func textFieldDidChange(_ textField: UITextField) {
    searchCustomViewDelegate?.updateTheVCWith(text: textField.text ?? "")
  }
  @IBAction func tapPopVCBTN(_ sender: Any) {
    searchCustomViewDelegate?.dismissAddNewCityVC()
  }
}
