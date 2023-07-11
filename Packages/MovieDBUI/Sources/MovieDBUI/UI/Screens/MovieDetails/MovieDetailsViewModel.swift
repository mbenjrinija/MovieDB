//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import Foundation
import MovieDBCore


public class MovieDetailsViewModel {
  
  private let repository: MoviesRepository
  private let movie: Movie
  
  @Published private var movieDetails: Loadable<MovieDetails> = .notLoaded
  
  /// derived attributes
  @Published var title: String = ""
  @Published var description: String = ""
  @Published var genres: String = ""
  @Published var posterURL: URL?
  @Published var isLoading: Bool = false
  private var bag = DisposeBag()
  
  public init(repository: MoviesRepository, movie: Movie) {
    self.repository = repository
    self.movie = movie
    setup()
  }
  
  func setup() {
    posterURL = repository.urlFor(posterPath: movie.posterPath)
    $movieDetails.map(\.value)
      .replaceError(with: nil)
      .compactMap { $0 }
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] movieDetail in
        self?.title = movieDetail.title ?? "-"
        self?.description = movieDetail.overview ?? "-"
        self?.genres = movieDetail.genres?
          .compactMap { $0.name }.joined(separator: ", ") ?? "-"
      }).store(in: &bag)
    $movieDetails
      .map(\.isLoading)
      .receive(on: DispatchQueue.main)
      .assign(to: \.isLoading, on: self)
      .store(in: &bag)
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
