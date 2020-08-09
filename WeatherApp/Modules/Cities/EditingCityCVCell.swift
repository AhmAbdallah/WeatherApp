//
//  EditingCityCVCell.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 5.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import UIKit
protocol EditingCityCVCellDelegate: AnyObject {
  func tapDelete(row: Int)
  func tapEdit(row: Int)}
class EditingCityCVCell: UICollectionViewCell {
  static let identifier = "EditingCityCVCell"
  weak var editingCityCVCellDelegate: EditingCityCVCellDelegate?
  var row: Int?
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLBL: UILabel!
  @IBOutlet weak var dateLBL: UILabel!
  @IBOutlet weak var tempLBL: UILabel!
  
  var list: List? {
    didSet {
      nameLBL.text = list?.name
      let inputFormatter = DateFormatter()
      inputFormatter.dateFormat = "dd/MM/yyyy"
      let day = inputFormatter.string(from: Date(timeIntervalSince1970: list!.listDT))
      dateLBL.text = day
      tempLBL.text = String(format: "%.0f", list?.main.temp.rounded() ?? 0) + "°C"
    }
  }
  
  @IBAction func tapDeletingBTN(_ sender: Any) {
    editingCityCVCellDelegate?.tapDelete(row: row!)
  }
  @IBAction func tapEditingBTN(_ sender: Any) {
    editingCityCVCellDelegate?.tapEdit(row: row!)
  }
}
