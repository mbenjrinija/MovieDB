//
//  MoviesRemoteDataSource.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation
import Combine
import MovieDBCore

// MARK: Protocol
public protocol MoviesRemoteDataSource: RemoteDataSource {
  func fetchMovies(page: Int) async throws -> PaginatedList<Movie>
  func fetchMovieDetails(id: Int) async throws -> MovieDetails
}

// MARK: Main Impl
public struct MoviesRemoteDataSourceMain: MoviesRemoteDataSource {
  public var networkManager: NetworkManager
  
  public init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }
  
  public func fetchMovies(page: Int) async throws -> PaginatedList<Movie> {
    try await fetch(call: Call.getMovies(page: page))
       .map { (response: MoviesListRemoteModel) -> PaginatedList<Movie> in
         response.transform()
      }
      .eraseToAnyPublisher()
      .async()
  }

  public func fetchMovieDetails(id: Int) async throws -> MovieDetails {
    return try await fetch(call: Call.getMovieDetails(id: id))
      .tryMap { (response: MovieDetailRemoteModel) throws -> MovieDetails in
        try response.transform()
      }
      .eraseToAnyPublisher()
      .async()
  }
}
