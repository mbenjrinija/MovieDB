//
//  MainComposer.swift
//  MovieDB
//
//  Created by Mouad Bj on 4/7/2023.
//

import UIKit
import MovieDBCore
import MovieDBUI

// MARK: - Main Dependency Composer
class MainComposer {
  
  let container: DIContainer
  var coordinator: AppCoordinator?
  
  init(container: DIContainer) {
    self.container = container
  }
  
  func startApp(with navigationController: UINavigationController) {
    coordinator = makeAppCoordinator(navigationController: navigationController)
    coordinator?.start()
  }
  
  func makeAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
    return AppCoordinatorMain(navigationController: navigationController, dependencyFactory: self)
  }
  
}

// MARK: - AppCoordinator Dependency Factory
extension MainComposer: AppCoordinatorDependencyFactory {

  func makeMoviesListScene() -> UIViewController? {
    guard let moviesInteractor = try? container.resolve(.Domain.Interactor.movies) ,
          let analyticsManager = try? container.resolve(.Domain.Interactor.analytics) else { return nil }
    let viewModel = MoviesListViewModel(
      moviesInteractor: moviesInteractor,
      analyticsManager: analyticsManager,
      goToDetails: coordinator?.goToDetailsOf
    )
    
    let viewController = MoviesListViewController.instantiateFromNib()
    viewController.viewModel = viewModel
    return viewController
  }
  
  func makeMovieDetailsScene(for movie: Movie) -> UIViewController? {
    guard let moviesRepository = try? container.resolve(.Data.Repository.Remote.movies) else { return nil }
    let viewModel = MovieDetailsViewModel(repository: moviesRepository, movie: movie)
    let viewController = MovieDetailsViewController.instantiateFromNib()
    viewController.viewModel = viewModel
    return viewController
  }

}
