//
//  MoviesRepository.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation
import Combine

protocol MoviesRepository {
  var moviesPaginator: CurrentValueSubject<Loadable<PaginatedList<Movie>>, Never> { get }
  func reloadMovies() async throws
  func fetchMoviesNextPage() async throws
  func fetchMovieDetails(id: Int) async throws -> MovieDetails
}

// handles data sources related to movies
class MoviesRepositoryMain: MoviesRepository {
  
  var remoteMovies: MoviesRemoteDataSource
  var moviesPaginator: CurrentValueSubject<Loadable<PaginatedList<Movie>>, Never> = .init(.notLoaded)
  
  init(remoteMovies: MoviesRemoteDataSource) {
    self.remoteMovies = remoteMovies
  }
  
  func reloadMovies() async throws {
    setMoviesAsLoading()
    let fetchedMovies = try await remoteMovies.fetchMovies(page: 1)
    moviesPaginator.send(.loaded(fetchedMovies))
  }
  
  func fetchMoviesNextPage() async throws {
    guard var currentMoviesPage = moviesPaginator.value.value else { return }
    if let nextPage = currentMoviesPage.nextPage() {
      // it does have a next page >> load it
      setMoviesAsLoading()
      let newMoviesPage = try await remoteMovies.fetchMovies(page: nextPage)
      currentMoviesPage.onNext(page: nextPage, items: newMoviesPage.results ?? [])
      moviesPaginator.send(.loaded(currentMoviesPage))
    }
  }

  func setMoviesAsLoading() {
    moviesPaginator.send(.loading(moviesPaginator.value.value))
  }

  func fetchMovieDetails(id: Int) async throws -> MovieDetails {
    return try await remoteMovies.fetchMovieDetails(id: id)
  }

}
