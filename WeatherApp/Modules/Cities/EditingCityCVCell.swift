//
//  EditingCityCVCell.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 5.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit
protocol EditingCityCVCellDelegate: AnyObject {
  func tapDelete(indexPath: IndexPath)
  func tapEdit(indexPath: IndexPath)}
class EditingCityCVCell: UICollectionViewCell {
  static let identifier = "EditingCityCVCell"
  weak var editingCityCVCellDelegate: EditingCityCVCellDelegate?
  var indexPath: IndexPath?
  @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var nameLBL: UILabel!
   @IBOutlet weak var dateLBL: UILabel!
   @IBOutlet weak var tempLBL: UILabel!
  @IBAction func tapDeletingBTN(_ sender: Any) {
    editingCityCVCellDelegate?.tapDelete(indexPath: indexPath!)
  }
  @IBAction func tapEditingBTN(_ sender: Any) {
    editingCityCVCellDelegate?.tapEdit(indexPath: indexPath!)
  }
}
