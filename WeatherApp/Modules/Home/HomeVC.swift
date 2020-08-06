//
//  HomeVC.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 2.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit
import Lottie

class HomeVC: UIViewController {
  var homeVM: HomeVM?
  private var homeCollectionView: UICollectionView!
  let animationView = AnimationView()
  lazy var refreshcontrol: UIRefreshControl = {
    let refreshcontrol = UIRefreshControl()
    refreshcontrol.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
    refreshcontrol.tintColor = UIColor.blueGrey
    return refreshcontrol
  }()
  init(homeVM: HomeVM) {
    self.homeVM = homeVM
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewUI()
  }
  override func viewWillAppear(_ animated: Bool) {
    setupNavigationController()
  }
}

// MARK: HomeVC
extension HomeVC {
  private func setupNavigationController() {
    //setupBackBTN()
    navigationItem.title = "Hava Durumu"
    navigationController?.navigationBar.titleTextAttributes = titleTextAttributes()
    navigationController?.navigationBar.barTintColor = .white
  }
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    //showProgress()
    //getSlider()
    //self.setupSlider()
    refreshcontrol.endRefreshing()
  }
  private func setupViewUI() {
    let flowLayout = UICollectionViewFlowLayout()
    homeCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
    //flowLayout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumInteritemSpacing = 0.0
    flowLayout.minimumLineSpacing = 0.0
    homeCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    view.addSubview(homeCollectionView)
    homeCollectionView.register(UINib(nibName: HomeGeneralCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeGeneralCVCell.identifier)
    homeCollectionView.register(UINib(nibName: HomeCitiesCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCitiesCVCell.identifier)
    homeCollectionView.register(UINib(nibName: HomeTimeCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeTimeCVCell.identifier)
    homeCollectionView.register(UINib(nibName: HomeDailyWeatherCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeDailyWeatherCVCell.identifier)
    homeCollectionView.register(UINib(nibName: HomeWeeklyWeatherCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeWeeklyWeatherCVCell.identifier)
    homeCollectionView!.translatesAutoresizingMaskIntoConstraints = false
    homeCollectionView!.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    homeCollectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    homeCollectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    homeCollectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    homeCollectionView!.backgroundColor = .appBackgroundColor
    homeCollectionView.showsVerticalScrollIndicator = false
    homeCollectionView .addSubview(refreshcontrol)
    homeCollectionView.delegate = self
    homeCollectionView.dataSource = self
  }
}

extension HomeVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
}

extension HomeVC: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 5
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0...4:
      return 1
    default:
      return 0
    }
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let section = indexPath.section
    switch section {
    case 0:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCitiesCVCell.identifier,
                                                          for: indexPath) as? HomeCitiesCVCell else {
                                                            fatalError("Unexpected Index Path")}
      cell.setupViewUI()
      return cell
    case 1:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGeneralCVCell.identifier,
                                                          for: indexPath) as? HomeGeneralCVCell else {
                                                            fatalError("Unexpected Index Path")}
      return cell
    case 2:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTimeCVCell.identifier,
                                                          for: indexPath) as? HomeTimeCVCell else {
                                                            fatalError("Unexpected Index Path")}
      cell.setupViewUI()
      return cell
    case 3:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeDailyWeatherCVCell.identifier,
                                                          for: indexPath) as? HomeDailyWeatherCVCell else {
                                                            fatalError("Unexpected Index Path")}
      return cell
    case 4:
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeWeeklyWeatherCVCell.identifier,
                                                        for: indexPath) as? HomeWeeklyWeatherCVCell else {
                                                          fatalError("Unexpected Index Path")}
    cell.updateUI()
    return cell
    default:
      return UICollectionViewCell()
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let section = indexPath.section
    let row = indexPath.row
    switch section {
    case 0:
      return CGSize(width: view.frame.size.width, height: 73)
    case 1:
      return CGSize(width: view.frame.size.width, height: 215)
    case 2:
      return CGSize(width: view.frame.size.width, height: 123)
    case 3:
      return CGSize(width: view.frame.size.width, height: 216)
    case 4:
    return CGSize(width: view.frame.size.width, height: 424)
    default:
      return CGSize(width: view.frame.size.width, height: 0)
    }
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}

// MARK: ViewControllerDelegate
extension HomeVC: ViewControllerDelegate {
  func vMShowProgressLoading() {
    showLottieLoader(animationView: animationView)
  }
  func vMHideProgressLoading() {
    hideLottieLoader(animationView: animationView)
  }
  func returnErrorWith(_ message: String) {
    hideLottieLoader(animationView: animationView)
    showDodoToast(message: message, dodoType: .error)
  }
  func returnSuccessWith(_ message: String) {
    hideLottieLoader(animationView: animationView)
    showDodoToast(message: message, dodoType: .success)
  }
}

//extension HomeVC: ProductReturningVMDelegate {
//  func updateUI() {
//    productReturningCV.delegate = self
//    productReturningCV.dataSource = self
//    productReturningCV.reloadData()
//  }
//}