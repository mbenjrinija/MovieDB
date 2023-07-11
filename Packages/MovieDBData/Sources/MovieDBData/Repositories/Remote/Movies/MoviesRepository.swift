//
//  MoviesRepository.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation
import Combine
import MovieDBCore

// handles data sources related to movies
public class MoviesRepositoryMain: MoviesRepository {
  
  let remoteMovies: MoviesRemoteDataSource
  
  public init(remoteMovies: MoviesRemoteDataSource) {
    self.remoteMovies = remoteMovies
  }
  
  public func fetchMovies(page: Int) async throws -> MovieDBCore.PaginatedList<MovieDBCore.Movie> {
    return try await remoteMovies.fetchMovies(page: page)
  }
  
  public func fetchMovieDetails(id: Int) async throws -> MovieDetails {
    return try await remoteMovies.fetchMovieDetails(id: id)
  }
  
  public func urlFor(posterPath: String?) -> URL? {
    // here we can handle returning a fallback placeholder image
    guard let posterPath else { return nil }
    return URL(string: "\(Constants.API.imagesBaseUrl)\(posterPath)")
  }
  
}
