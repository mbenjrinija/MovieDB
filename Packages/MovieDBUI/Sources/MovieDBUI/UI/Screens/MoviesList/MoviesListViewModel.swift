//
//  MoviesListViewModel.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation
import Combine
import MovieDBCore

public class MoviesListViewModel {
  
  let moviesInteractor: MoviesInteractor
  let analyticsManager: AnalyticsService
  let goToDetails: ((Movie) -> (Void))?
  
  var movies: AnyPublisher<[MovieCellViewModel], Never> {
    get {
      moviesInteractor.moviesPaginator.map { loadable in
        loadable.value?.results
      }
      .replaceError(with: [])
        .replaceNil(with: [])
        .map({movies in
          movies.map {
            MovieCellViewModel(
              movie: $0,
              posterURL: self.moviesInteractor.urlFor(posterPath: $0.posterPath))
          }
        })
        .eraseToAnyPublisher()
    }
  }
  
  var isLoading: AnyPublisher<Bool, Never> {
    get {
      moviesInteractor.moviesPaginator.map { $0.isLoading}
        .eraseToAnyPublisher()
    }
  }
  
  @Published var error: String?
  
  public init(moviesInteractor: MoviesInteractor,
       analyticsManager: AnalyticsService,
       goToDetails: ((Movie) -> Void)?) {
    self.moviesInteractor = moviesInteractor
    self.analyticsManager = analyticsManager
    self.goToDetails = goToDetails
    self.start()
  }

  func start() {
    self.analyticsManager.sendScreen(event: .screenViewed(name: "MoviesList"))
  }
  
  func refreshMovies() {
    Task {
      do {
        try await moviesInteractor.reloadMovies()
      } catch(let error) {
        self.error = error.localizedDescription
      }
    }
  }
  
  func loadNextMoviesPage() {
    guard !moviesInteractor.moviesPaginator.value.isLoading else { return }
    Task {
      do {
        try await moviesInteractor.fetchMoviesNextPage()
      } catch(let error) {
        self.error = error.localizedDescription
      }
    }
  }
  
  func didSelect(movie: Movie) {
    goToDetails?(movie)
  }
}
