//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
  
  var parentCoordinator: Coordinator? = nil
  var children: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    // init app
  }
  
}
