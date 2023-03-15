//
//  MoviesRemoteDataSource.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation
import Combine

// MARK: Protocol
protocol MoviesRemoteDataSource: RemoteDataSource {
  func fetchMovies() async throws -> PaginatedList<Movie>
  func fetchMovieDetails(id: Int) async throws -> MovieDetails
}

// MARK: Main Impl
struct MoviesRemoteDataSourceMain: MoviesRemoteDataSource {
  let session: URLSession

  func fetchMovies() async throws -> PaginatedList<Movie> {
    try await fetch(call: Call.getMovies)
       .map { (response: MoviesListRemoteModel) -> PaginatedList<Movie> in
         response.transform()
      }
      .eraseToAnyPublisher()
      .async()
  }

  func fetchMovieDetails(id: Int) async throws -> MovieDetails {
    try await fetch(call: Call.getMovieDetails(id: id))
      .map { (response: MovieDetailRemoteModel) -> MovieDetails in
        response.transform()
      }
      .eraseToAnyPublisher()
      .async()
  }
}
