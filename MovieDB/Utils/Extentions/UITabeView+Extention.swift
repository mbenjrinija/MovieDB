//
//  UITabeView+Extention.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import UIKit

extension UITableView {
  func register<Cell: UITableViewCell>(cellType: Cell.Type) {
    register(UINib(nibName: cellType.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cellType.reuseIdentifier)
  }
  
  func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
    guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
      fatalError("Could not dequeue cell with identifier \(Cell.reuseIdentifier)")
    }
    return cell
  }
}

extension UITableViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
