//
//  File.swift
//  
//
//  Created by Mouad Bj on 5/7/2023.
//

import Foundation
import Combine

public protocol MoviesRepository {
  func fetchMovies(page: Int) async throws -> PaginatedList<Movie>
  func fetchMovieDetails(id: Int) async throws -> MovieDetails
  func urlFor(posterPath: String?) -> URL?
}
