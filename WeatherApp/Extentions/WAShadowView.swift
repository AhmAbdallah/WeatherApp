//
//  WAShadowView.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
  @IBInspectable var shadowColor: UIColor? {
    set {
      guard let uiColor = newValue else { return }
      layer.shadowColor = uiColor.cgColor
    }
    get {
      guard let color = layer.shadowColor else { return nil }
      return UIColor(cgColor: color)
    }
  }
  @IBInspectable var shadowOpacity: Float {
    set {
      layer.shadowOpacity = newValue
    }
    get {
      return layer.shadowOpacity
    }
  }
  @IBInspectable var shadowOffset: CGSize {
    set {
      layer.shadowOffset = newValue
    }
    get {
      return layer.shadowOffset
    }
  }
  @IBInspectable var shadowRadius: CGFloat {
    set {
      layer.shadowRadius = newValue
    }
    get {
      return layer.shadowRadius
    }
  }
  private struct AssociatedKey {
    static var rounded = "UIView.rounded"
  }
  @IBInspectable var rounded: Bool {
    get {
      if let rounded = objc_getAssociatedObject(self, &AssociatedKey.rounded) as? Bool {
        return rounded
      } else {
        return false
      }
    }
    set {
      objc_setAssociatedObject(self, &AssociatedKey.rounded, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      layer.cornerRadius = CGFloat(newValue ? 1.0 : 0.0)*min(bounds.width, bounds.height)/2
    }
  }
  @IBInspectable var borderWidth: CGFloat {
    set {
      layer.borderWidth = newValue
    }
    get {
      return layer.borderWidth
    }
  }
  @IBInspectable var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
    }
    get {
      return layer.cornerRadius
    }
  }
  @IBInspectable var borderColor: UIColor? {
    set {
      guard let uiColor = newValue else { return }
      layer.borderColor = uiColor.cgColor
    }
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
  }
}
