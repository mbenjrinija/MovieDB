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

extension UITableView {
  func showLoading() {
    self.reloadData()
    let tableViewHeight = self.bounds.size.height
    let cells = self.visibleCells
    var delayCounter = 0
    for cell in cells {
      cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
    }
    for cell in cells {
      UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
        cell.transform = CGAffineTransform.identity
      }, completion: nil)
      delayCounter += 1
    }
  }
}

extension UITableViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
