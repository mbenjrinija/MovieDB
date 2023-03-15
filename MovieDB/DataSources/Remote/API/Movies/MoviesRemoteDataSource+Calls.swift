//
//  MoviesRemoteDataSource+Call.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

// MARK: API Calls enum
extension MoviesRemoteDataSourceMain {
  enum Call {
    case getMovies
    case getMovieDetails(id: Int)
  }
}


// MARK: API Calls config
extension MoviesRemoteDataSourceMain.Call: RemoteCall {
  var auth: AuthStrategy { NoAuth() }
  
  var path: String {
    switch self {
    case .getMovies:
      return "/discover/movie"
    case .getMovieDetails(let id):
      return "/movie/\(id)"
    }
  }
  
  var method: String {
    switch self {
    case .getMovies, .getMovieDetails:
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
