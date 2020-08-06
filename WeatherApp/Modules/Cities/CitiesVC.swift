//
//  CitiesVC.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 4.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit
import Lottie

class CitiesVC: UIViewController {
  var citiesVM: CitiesVM?
  var citiesCoordinator: CitiesCoordinator?
  private var citiesCollectionView: UICollectionView!
  let animationView = AnimationView()
  var editTheCitiesBTN: UIBarButtonItem!
  var editingModeIsActive = false
  lazy var refreshcontrol: UIRefreshControl = {
    let refreshcontrol = UIRefreshControl()
    refreshcontrol.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
    refreshcontrol.tintColor = UIColor.blueGrey
    return refreshcontrol
  }()
  init(citiesVM: CitiesVM) {
    self.citiesVM = citiesVM
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

// MARK: CitiesVC
extension CitiesVC {
  private func setupNavigationController() {
    //setupBackBTN()
    navigationItem.title = "Şehirler"
    navigationController?.navigationBar.titleTextAttributes = titleTextAttributes()
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.tintColor = .purplyBlue
    let addNewCityBTN = UIBarButtonItem.init(image: R.image.iconAddNewCity(), style: .plain, target: self, action: #selector(addNewCity))
    navigationItem.rightBarButtonItem = addNewCityBTN
    editTheCitiesBTN = UIBarButtonItem(title: "Düzenle", style: .plain, target: self, action: #selector(editTheCities))
    navigationItem.leftBarButtonItem = editTheCitiesBTN
  }
  @objc func addNewCity() {
    citiesCoordinator?.openAddNewCityVC()
  }
  @objc func editTheCities() {
    if editingModeIsActive {
      editingModeIsActive = false
      editTheCitiesBTN?.title = "Düzenle"
      citiesCollectionView.reloadData()
    } else {
      editingModeIsActive = true
      editTheCitiesBTN?.title = "Bitti"
      citiesCollectionView.reloadData()
    }
  }
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    //showProgress()
    //getSlider()
    //self.setupSlider()
    refreshcontrol.endRefreshing()
  }
  private func setupViewUI() {
    let flowLayout = UICollectionViewFlowLayout()
    citiesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
    //flowLayout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumInteritemSpacing = 0.0
    flowLayout.minimumLineSpacing = 0.0
    citiesCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    view.addSubview(citiesCollectionView)
    citiesCollectionView.register(UINib(nibName: CityCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: CityCVCell.identifier)
    citiesCollectionView.register(UINib(nibName: EditingCityCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: EditingCityCVCell.identifier)
    citiesCollectionView!.translatesAutoresizingMaskIntoConstraints = false
    citiesCollectionView!.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    citiesCollectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    citiesCollectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    citiesCollectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    citiesCollectionView!.backgroundColor = .appBackgroundColor
    citiesCollectionView.showsVerticalScrollIndicator = false
    citiesCollectionView .addSubview(refreshcontrol)
    citiesCollectionView.delegate = self
    citiesCollectionView.dataSource = self
  }
}

extension CitiesVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
}

extension CitiesVC: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if editingModeIsActive {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditingCityCVCell.identifier,
                                                          for: indexPath) as? EditingCityCVCell else {
                                                            fatalError("Unexpected Index Path")}
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCVCell.identifier,
                                                          for: indexPath) as? CityCVCell else {
                                                            fatalError("Unexpected Index Path")}
      return cell
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CitiesVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 88)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}

// MARK: ViewControllerDelegate
extension CitiesVC: ViewControllerDelegate {
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
