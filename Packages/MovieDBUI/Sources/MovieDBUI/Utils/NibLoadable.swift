//
//  XibViewController.swift
//  
//
//  Created by Mouad Bj on 5/7/2023.
//

import UIKit

public protocol NibLoadable {
  static func instantiateFromNib() -> Self
}

extension NibLoadable where Self: UIViewController {
  public static func instantiateFromNib() -> Self {
    let bundle = Bundle.module
    let nibName = String(describing: self)
    return Self(nibName: nibName, bundle: bundle)
  }
}
