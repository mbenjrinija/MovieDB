//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation
import UIKit
import MovieDBCore

public protocol AppCoordinatorDependencyFactory: AnyObject {
  func makeMovieDetailsScene(for movie: Movie) -> UIViewController?
  func makeMoviesListScene() -> UIViewController?
}

public protocol AppCoordinator: Coordinator {
  func goToDetailsOf(movie: Movie)
}

public class AppCoordinatorMain: AppCoordinator {
  
  public var parentCoordinator: Coordinator? = nil
  public var children: [Coordinator] = []
  public var navigationController: UINavigationController
  private weak var dependencyFactory: AppCoordinatorDependencyFactory?
  
  public init(navigationController: UINavigationController, dependencyFactory: AppCoordinatorDependencyFactory) {
    self.navigationController = navigationController
    self.dependencyFactory = dependencyFactory
  }
  
  public func start() {
    guard let viewController = dependencyFactory?.makeMoviesListScene() else { return }
    navigationController.pushViewController(viewController, animated: true)
  }
  
  public func goToDetailsOf(movie: Movie) {
    guard let viewController = dependencyFactory?.makeMovieDetailsScene(for: movie) else { return }
    navigationController.pushViewController(viewController, animated: true)
  }
  
}
