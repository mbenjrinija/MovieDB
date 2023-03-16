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
    let moviesRemoteDataSource = MoviesRemoteDataSourceMain(session: .default)
    let moviesRepository = MoviesRepositoryMain(remoteMovies: moviesRemoteDataSource)
    let viewModel = MoviesListViewModel(repository: moviesRepository,
                      goToDetails: { [weak self] in self?.goToDetailsOf(movie: $0) })
    let viewController = MoviesListViewController(nibName: "MoviesListViewController", bundle: nil)
    viewController.viewModel = viewModel
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func goToDetailsOf(movie: Movie) {
    
  }
  
}
