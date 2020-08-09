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
  var isAddingMode = false
  var searchCustomView: SearchCustomView?
  private var lastContentOffset: CGFloat = 0
  var addNewCityTableView: UITableView!
  
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
    if !isAddingMode {
      showDodoToast(message: "Lütfen en az 3 ekler mısınız", dodoType: .info)
    }
  }
}

// MARK: AddNewCityVC
extension AddNewCityVC {
  fileprivate func setupNavigationController() {
    navigationController?.navigationBar.titleTextAttributes = titleTextAttributes()
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.titleTextAttributes = titleTextAttributes()
    navigationController?.navigationBar.barTintColor = .white
    if let view = SearchCustomView.instanceFromNib() as? SearchCustomView {
      view.frame.size.width = navigationController!.navigationBar.frame.size.width
      view.frame.size.height = navigationController!.navigationBar.frame.size.height
      view.isAddingMode = isAddingMode
      view.searchCustomViewDelegate = self
      searchCustomView = view
      navigationController?.navigationBar.addSubview(view)
    }
  }
  
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    refreshcontrol.endRefreshing()
  }
  
  private func setupCollectionView() {
    addNewCityTableView = UITableView(frame: self.view.frame)
    view.addSubview(addNewCityTableView)
    
    addNewCityTableView.register(UINib(nibName: AddNewCityTVCell.identifier, bundle: nil), forCellReuseIdentifier: AddNewCityTVCell.identifier)
    
    addNewCityTableView.translatesAutoresizingMaskIntoConstraints = false
    addNewCityTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    addNewCityTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    addNewCityTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    addNewCityTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    addNewCityTableView.backgroundColor = .appBackgroundColor
    addNewCityTableView.tintColor = .slate
    addNewCityTableView.sectionIndexTrackingBackgroundColor = UIColor.clear
    addNewCityTableView.sectionIndexBackgroundColor = UIColor.clear
    view.backgroundColor = .appBackgroundColor
    addNewCityTableView.showsVerticalScrollIndicator = false
    addNewCityTableView.separatorColor = .none
    addNewCityTableView.addSubview(refreshcontrol)
    addNewCityTableView.dataSource = self
  }
}

extension AddNewCityVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return addNewCityVM?.getSectionCount() ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return addNewCityVM?.getRowCountFor(section: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = indexPath.row
    let section = indexPath.section
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AddNewCityTVCell.identifier,
                                                   for: indexPath) as? AddNewCityTVCell else {
                                                    fatalError("Unexpected Index Path")}
    cell.city = addNewCityVM?.getCityFor(section: section, row: row)
    cell.addNewCityTVCellDelegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return addNewCityVM?.getTitleFor(section: section)
  }
  
  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return addNewCityVM?.getSectionIndexTitles()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //may we can handle it, if the customer selected the cell
  }
}

extension AddNewCityVC: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
      navigationController?.setNavigationBarHidden(false, animated: true)
    } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
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
  }
  
  func returnSuccessWith(_ message: String) {
    hideLottieLoader(animationView: animationView)
    showDodoToast(message: message, dodoType: .success)
  }
}

extension AddNewCityVC: AddNewCityVMDelegate {
  func openHomePage() {
    let tabBar = MainTabBarC()
    tabBar.modalPresentationStyle = .fullScreen
    navigationController?.present(tabBar, animated: true, completion: nil)
  }
  
  func showInfo(message: String) {
    showDodoToast(message: message, dodoType: .info)
  }
}
extension AddNewCityVC: AddNewCityTVCellDelegate {
  func addCityWith(city: City?) {
    addNewCityVM?.addCityWith(city: city, isAddingMode: isAddingMode)
  }
}

extension AddNewCityVC: SearchCustomViewDelegate {
  func updateTheVCWith(text: String) {
    //Handle search process
  }
  
  func dismissAddNewCityVC() {
    navigationController?.navigationBar.willRemoveSubview(searchCustomView!)
    dismiss(animated: true, completion: nil)
  }
}
