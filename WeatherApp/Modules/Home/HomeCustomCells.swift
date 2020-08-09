//
//  HomeCustomCells.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 6.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class HomeCustomCells {
  private var homeVC: HomeVC?
  private var homeVM: HomeVM?
  internal init(homeVC: HomeVC?, homeVM: HomeVM?) {
    self.homeVC = homeVC
    self.homeVM = homeVM
  }
  func getHomeCitiesCVCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCitiesCVCell.identifier,
                                                        for: indexPath) as? HomeCitiesCVCell else {
                                                          fatalError("Unexpected Index Path")}
    cell.homeCitiesCVCellDelegate = homeVC
    cell.citiesArray = WeatherAppSessionManager.shared.citiesArray
    cell.setupViewUI()
    return cell
  }
  func getHomeGeneralCVCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGeneralCVCell.identifier,
                                                        for: indexPath) as? HomeGeneralCVCell else {
                                                          fatalError("Unexpected Index Path")}
    cell.cityWeatherModel = homeVM?.cityWeatherModel
    return cell
  }
  func getHomeTimeCVCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTimeCVCell.identifier,
                                                        for: indexPath) as? HomeTimeCVCell else {
                                                          fatalError("Unexpected Index Path")}
    cell.setupViewUI()
    return cell
  }
  func getHomeDailyWeatherCVCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeDailyWeatherCVCell.identifier,
                                                        for: indexPath) as? HomeDailyWeatherCVCell else {
                                                          fatalError("Unexpected Index Path")}
    cell.cityWeatherModel = homeVM?.cityWeatherModel
    return cell
  }
  func getHomeWeeklyWeatherCVCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeWeeklyWeatherCVCell.identifier,
                                                        for: indexPath) as? HomeWeeklyWeatherCVCell else {
                                                          fatalError("Unexpected Index Path")}
    cell.data = homeVM?.weeklyModel?.data
    return cell
  }
}
