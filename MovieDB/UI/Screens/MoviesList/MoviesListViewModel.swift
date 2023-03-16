//
//  MoviesListViewModel.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation
import Combine

class MoviesListViewModel {
  
  let repository: MoviesRepository
  let goToDetails: ((Movie) -> (Void))?
  
  var movies: AnyPublisher<[Movie], Never> {
    get {
      repository.moviesPaginator.map { loadable in
        loadable.value?.results
      }.replaceError(with: [])
        .replaceNil(with: [])
        .eraseToAnyPublisher()
    }
  }
  
  var isLoading: AnyPublisher<Bool, Never> {
    get {
      repository.moviesPaginator.map { $0.isLoading}
        .eraseToAnyPublisher()
    }
  }
  
  @Published var error: String?
  
  init(repository: MoviesRepository, goToDetails: @escaping ((Movie) -> (Void))) {
    self.repository = repository
    self.goToDetails = goToDetails
  }
  
  func refreshMovies() {
    Task {
      do {
        try await repository.reloadMovies()
      } catch(let error) {
        self.error = error.localizedDescription
      }
    }
  }
  
  func loadNextMoviesPage() {
    guard !repository.moviesPaginator.value.isLoading else { return }
    Task {
      do {
        try await repository.fetchMoviesNextPage()
      } catch(let error) {
        self.error = error.localizedDescription
      }
    }
  }
  
  func didSelect(movie: Movie) {
    goToDetails?(movie)
  }
}
