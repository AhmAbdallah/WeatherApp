//
//  HomeTimeCVCell.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 4.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

class HomeTimeCVCell: UICollectionViewCell {
  static let identifier = "HomeTimeCVCell"
  @IBOutlet weak var timeCollectionView: UICollectionView!
  func setupViewUI() {
      timeCollectionView.register(UINib(nibName: TimeCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: TimeCVCell.identifier)
      timeCollectionView.delegate = self
      timeCollectionView.dataSource = self
    }
  }

  extension HomeTimeCVCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
  }

  extension HomeTimeCVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 12
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //let row = indexPath.row
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCVCell.identifier,
                                                          for: indexPath) as? TimeCVCell else {
                                                            fatalError("Unexpected Index Path")}
      return cell
    }
  }

  // MARK: - UICollectionViewDelegateFlowLayout
  extension HomeTimeCVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 84, height: 123)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 0.0
    }
  }
