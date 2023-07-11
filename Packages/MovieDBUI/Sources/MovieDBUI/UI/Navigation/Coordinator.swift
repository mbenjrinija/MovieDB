//
//  Coordinator.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation
import UIKit

public protocol Coordinator {
  
  var parentCoordinator: Coordinator? { get set }
  var children: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  
  func start()
  
}
