//
//  UIViewController+Extention.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit
import Dodo
import Lottie
import SwiftyJSON

protocol GenderDelegate: AnyObject {
  func userGender(gender: String)
}

protocol ListDelegate: AnyObject {
  func openCartView()
  func openCompareView()
}

protocol ProductDetailsDelegate: AnyObject {
  func openCartViewFromPD()
  func openCompareViewFromPD()
}

// MARK: UIViewController
extension UIViewController {
  func titleTextAttributes() -> [NSAttributedString.Key: Any]? {
    return [.foregroundColor: UIColor.slate]
  }
  func setupBackBTN() {
    navigationItem.leftBarButtonItem = createBackBTN()
  }
  func createBackBTN() -> UIBarButtonItem {
    let popBTN = UIBarButtonItem.init(image: R.image.iconBackBtn(), style: .plain, target: self, action: #selector(popVC))
    return popBTN
  }
  @objc func popVC() {
    self.navigationController?.popViewController(animated: true)
  }
  func setupDismissBackBTN() {
    navigationItem.leftBarButtonItem = createDismissBackBTN()
  }
  private func createDismissBackBTN() -> UIBarButtonItem {
    let popBTN = UIBarButtonItem.init(image: R.image.iconBackBtn(), style: .plain, target: self, action: #selector(popDismissVC))
    return popBTN
  }
  @objc func popDismissVC() {
    self.dismissDetail()
  }
}

// MARK: Dodo
extension UIViewController {
  func showDodoToast(message: String, dodoType: DodoType) {
    customDodoView(message: message, dodoType: dodoType)
  }
  func showDodoLoadingToast() {
    view.dodo.topAnchor = view.safeAreaLayoutGuide.topAnchor
    view.dodo.bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
    view.dodo.success("Yükleniyor")
  }
  func hideLoadingToast() {
    view.dodo.hide()
  }
  fileprivate func customDodoView(message: String, dodoType: DodoType) {
    view.dodo.style.label.color = UIColor.white
    view.dodo.style.bar.hideAfterDelaySeconds = 3
    view.dodo.style.bar.hideOnTap = true
    view.dodo.style.bar.animationShow = DodoAnimations.slideVertically.show
    view.dodo.style.bar.animationHide = DodoAnimations.slideVertically.hide
    view.dodo.topAnchor = view.safeAreaLayoutGuide.topAnchor
    view.dodo.bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
    switch dodoType {
    case .success:
      view.dodo.style.bar.backgroundColor = UIColor.mariGold
      view.dodo.success(message)
    case .info:
      view.dodo.style.bar.backgroundColor = UIColor.infoColor
      view.dodo.info(message)
    case .warning:
      view.dodo.style.bar.backgroundColor = UIColor.warningColor
      view.dodo.warning(message)
    case .error:
      view.dodo.style.bar.backgroundColor = UIColor(displayP3Red: 245/255, green: 110/255, blue: 100/255, alpha: 1)
      view.dodo.error(message)
    }
  }
}

enum DodoType {
  case success
  case info
  case warning
  case error
}

// MARK: Lottie
extension UIViewController {
  func showLottieLoader(animationView: AnimationView) {
    let containerView = UIView()
    containerView.frame = UIScreen.main.bounds
    containerView.backgroundColor = .clear
    containerView.alpha = 0.25
    containerView.tag = 101
    UIApplication.shared.keyWindow?.addSubview(containerView)
    view.addSubview(animationView)
    animationView.layer.zPosition = 1
    let animation = Animation.named("wAppAnimation")
    animationView.animation = animation
    animationView.contentMode = .scaleToFill
    animationView.tag = 100
    animationView.loopMode = .loop
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    animationView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    animationView.play()
  }
  func hideLottieLoader(animationView: AnimationView) {
    animationView.stop()
    for view in UIApplication.shared.keyWindow!.subviews where view.tag == 101 {
      view.removeFromSuperview()
    }
    for view in self.view.subviews where view.tag == 100 {
      view.removeFromSuperview()
    }
  }
}

protocol ViewControllerDelegate: class {
  func vMShowProgressLoading()
  func vMHideProgressLoading()
  func returnErrorWith(_ message: String)
  func returnSuccessWith(_ message: String)
}

// MARK: String Height and width
extension String {
  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    return ceil(boundingBox.height)
  }
  func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    return ceil(boundingBox.width)
  }
}

extension UIViewController {
  func presentDetail(_ viewControllerToPresent: UIViewController) {
    self.view.window!.backgroundColor = .white
    let transition = CATransition()
    transition.duration = 0.25
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    self.view.window!.layer.add(transition, forKey: kCATransition)
    
    present(viewControllerToPresent, animated: false)
  }
  
  func dismissDetail() {
    self.view.window!.backgroundColor = .white
    let transition = CATransition()
    transition.duration = 0.25
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromLeft
    self.view.window!.layer.add(transition, forKey: kCATransition)
    
    dismiss(animated: false)
  }
}
