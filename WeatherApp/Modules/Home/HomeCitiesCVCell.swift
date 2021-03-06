//
//  HomeCitiesCVCell.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 3.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit

protocol HomeCitiesCVCellDelegate: AnyObject {
  func getDataFor(cityID: Int)
}
class HomeCitiesCVCell: UICollectionViewCell {
  static let identifier = "HomeCitiesCVCell"
  var selectedIndex = 0
  weak var homeCitiesCVCellDelegate: HomeCitiesCVCellDelegate?
  @IBOutlet weak var citiesCollectionView: UICollectionView!
  var citiesArray: [City]?
  func setupViewUI() {
    citiesCollectionView.register(UINib(nibName: HomeCityCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCityCVCell.identifier)
    citiesCollectionView.delegate = self
    citiesCollectionView.dataSource = self
    citiesCollectionView.reloadData()
  }
}

extension HomeCitiesCVCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIndex = indexPath.row
    homeCitiesCVCellDelegate?.getDataFor(cityID: citiesArray?[indexPath.row].cityId ?? 0)
    citiesCollectionView.reloadData()
  }
}

extension HomeCitiesCVCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return citiesArray?.count ?? 0
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let row = indexPath.row
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCityCVCell.identifier,
                                                        for: indexPath) as? HomeCityCVCell else {
                                                          fatalError("Unexpected Index Path")}
    if selectedIndex == row {
      cell.cityLBL.textColor = .white
      cell.cityLBL.backgroundColor = .purplyBlue
    } else {
      cell.cityLBL.textColor = .slate
      cell.cityLBL.backgroundColor = .clear
    }
    cell.cityLBL.text = citiesArray?[row].name
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCitiesCVCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let row = indexPath.row
    return CGSize(width: (citiesArray?[row].name.width(withConstraintedHeight: 28, font: R.font.robotoMedium(size: 14)!))! + 30, height: 28)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}
