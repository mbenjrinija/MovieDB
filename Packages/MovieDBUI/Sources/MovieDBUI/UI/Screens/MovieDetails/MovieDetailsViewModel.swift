//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import Foundation
import MovieDBCore


public class MovieDetailsViewModel {
  
  let repository: MoviesRepository
  let movie: Movie
  
  @Published var movieDetails: Loadable<MovieDetails> = .notLoaded
  
  var posterURL: URL? {
    repository.urlFor(posterPath: movie.posterPath)
  }
  
  public init(repository: MoviesRepository, movie: Movie) {
    self.repository = repository
    self.movie = movie
  }
  
  func loadDetails() {
    movieDetails = .loading(nil)
    Task {
      do {
        let result = try await repository.fetchMovieDetails(id: movie.id!)
        movieDetails = .loaded(result)
      } catch(let error) {
        movieDetails = .failed(nil, error)
      }
    }
  }
  
}
