//
//  AddNewCityVC.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 5.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit
import Lottie

class AddNewCityVC: UIViewController {
  var addNewCityVM: AddNewCityVM?
  let animationView = AnimationView()
  let searchBar = UISearchBar()
  private var lastContentOffset: CGFloat = 0
  var addNewCityCollectionView: UICollectionView!
  lazy var refreshcontrol: UIRefreshControl = {
    let refreshcontrol = UIRefreshControl()
    refreshcontrol.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
    refreshcontrol.tintColor = UIColor.purplyBlue
    return refreshcontrol
  }()
  init(addNewCityVM: AddNewCityVM?) {
    self.addNewCityVM = addNewCityVM
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = false
    setupNavigationController()
  }
}

// MARK: AddNewCityVC
extension AddNewCityVC {
  fileprivate func setupNavigationController() {
    navigationController?.navigationBar.titleTextAttributes = titleTextAttributes()
    navigationController?.navigationBar.barTintColor = .white
    //searchBar.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 241/255, alpha: 1.00)
    searchBar.delegate = self
    searchBar.showsCancelButton = false
    searchBar.sizeToFit()
    self.navigationController?.navigationBar.topItem?.titleView = searchBar
    setupDismissBackBTN()
  }
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    refreshcontrol.endRefreshing()
  }
  private func setupCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    addNewCityCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumInteritemSpacing = 0.0
    flowLayout.minimumLineSpacing = 0.0
    addNewCityCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    view.addSubview(addNewCityCollectionView)
    addNewCityCollectionView.register(UINib(nibName: AddNewCityCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddNewCityCVCell.identifier)
    addNewCityCollectionView.translatesAutoresizingMaskIntoConstraints = false
    addNewCityCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    addNewCityCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    addNewCityCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    addNewCityCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    addNewCityCollectionView.backgroundColor = .appBackgroundColor
    view.backgroundColor = .white
    addNewCityCollectionView.showsVerticalScrollIndicator = false
    addNewCityCollectionView.addSubview(refreshcontrol)
    addNewCityCollectionView.dataSource = self
    addNewCityCollectionView.delegate = self
  }
  @objc func dismissNotificationsV() {
    self.dismiss(animated: true, completion: nil)
  }
}

extension AddNewCityVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let row =  indexPath.row
    //    let product = offersVM?.getProductFor(index: row)
    //    if let productId = product?.pRODUCTID {
    //      let productDetailsVM = ProductDetailsVM()
    //      let productDetailsVC = ProductDetailsVC(productDetailsVM: productDetailsVM)
    //      productDetailsVM.productDetailsVMDelegate = productDetailsVC
    //      productDetailsVM.viewControllerDelegate = productDetailsVC
    //      productDetailsVM.productId = "\(productId)"
    //      navigationController?.pushViewController(productDetailsVC, animated: true)
    //    }
  }
}

extension AddNewCityVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let row = indexPath.row
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNewCityCVCell.identifier,
                                                        for: indexPath) as? AddNewCityCVCell else {
                                                          fatalError("Unexpected Index Path")}
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddNewCityVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 49)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}

extension AddNewCityVC: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
      print("move up")
      //        navigationController?.hidesBarsOnSwipe = false
      //        navigationController?.isNavigationBarHidden = false
      navigationController?.setNavigationBarHidden(false, animated: true)
    } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
      print("move down")
      navigationController?.setNavigationBarHidden(true, animated: true)
    }
    lastContentOffset = scrollView.contentOffset.y
  }
}

// MARK: ViewControllerDelegate
extension AddNewCityVC: ViewControllerDelegate {
  func vMShowProgressLoading() {
    showLottieLoader(animationView: animationView)
  }
  func vMHideProgressLoading() {
    hideLottieLoader(animationView: animationView)
  }
  func returnErrorWith(_ message: String) {
    hideLottieLoader(animationView: animationView)
    showDodoToast(message: message, dodoType: .error)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.dismiss(animated: true)
    }
  }
  func returnSuccessWith(_ message: String) {
    hideLottieLoader(animationView: animationView)
    showDodoToast(message: message, dodoType: .success)
  }
}

//extension AddNewCityVC: SearchVMDelegate {
//  func updateUI() {
//    addNewCityCollectionView.dataSource = self
//    addNewCityCollectionView.delegate = self
//    addNewCityCollectionView.reloadData()
//  }
//}

extension AddNewCityVC: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.endEditing(true)
    searchBar.showsCancelButton = false
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print("searchText \(searchBar.text!)")
    searchBar.endEditing(true)
    //searchVM?.getSearchData(keyWord: searchBar.text!)
  }
}
