//
//  MoviesRemoteDataSource.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation
import Combine

protocol MoviesRemoteDataSource: RemoteDataSource {
  func fetchMovies() async throws -> [Movie]
}

struct MoviesRemoteDataSourceMain: MoviesRemoteDataSource {

  let session: URLSession

  func fetchMovies() async throws -> [Movie] {
    try await fetch(call: Call.getMovies)
       .map { (response: MoviesListRemoteModel) -> [Movie] in
        response.results?.map { movie in
          Movie(id: movie.id,
                title: movie.title,
                originalTitle: movie.originalTitle,
                posterPath: movie.posterPath,
                releaseDate: movie.releaseDate,
                voteAverage: movie.voteAverage)
        } ?? []
      }
      .eraseToAnyPublisher()
      .async()
  }

}

extension MoviesRemoteDataSourceMain {
  enum Call {
    case getMovies
  }
}

extension MoviesRemoteDataSourceMain.Call: RemoteCall {
  var auth: AuthStrategy { NoAuth() }
  var path: String {
    switch self {
    case .getMovies:
      return "/discover/movie"
    }
  }
  var method: String {
    switch self {
    case .getMovies:
      return "GET"
    }
  }
  var headers: [String: String]? {
    nil // no default headers
  }

  var params: [String: String]? {
    nil // no default params
  }

  func body() throws -> Data? {
    nil // no default body
  }

}
