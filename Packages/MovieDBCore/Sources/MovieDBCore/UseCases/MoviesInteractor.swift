//
//  Created by Mouad Bj on 6/7/2023.
//

import Foundation
import Combine

public protocol MoviesInteractor {
  var moviesPaginator: CurrentValueSubject<Loadable<PaginatedList<Movie>>, Never> { get }
  func reloadMovies() async throws
  func fetchMoviesNextPage() async throws
  func urlFor(posterPath: String?) -> URL?
}

public class MovieInteractorMain: MoviesInteractor {
  
  public var moviesPaginator: CurrentValueSubject<Loadable<PaginatedList<Movie>>, Never> = .init(.notLoaded)
  let moviesRepository: MoviesRepository
  
  public init(moviesRepository: MoviesRepository) {
    self.moviesRepository = moviesRepository
  }
  
  public func reloadMovies() async throws {
    setMoviesAsLoading()
    let fetchedMovies = try await moviesRepository.fetchMovies(page: 1)
    moviesPaginator.send(.loaded(fetchedMovies))
  }
  
  public func fetchMoviesNextPage() async throws {
    guard var currentMoviesPage = moviesPaginator.value.value else { return }
    if let nextPage = currentMoviesPage.nextPage() {
      // it does have a next page >> load it
      setMoviesAsLoading()
      let newMoviesPage = try await moviesRepository.fetchMovies(page: nextPage)
      currentMoviesPage.onNext(page: nextPage, items: newMoviesPage.results ?? [])
      moviesPaginator.send(.loaded(currentMoviesPage))
    }
  }
  
  public func setMoviesAsLoading() {
    moviesPaginator.send(.loading(moviesPaginator.value.value))
  }
  
  public func urlFor(posterPath: String?) -> URL? {
    return moviesRepository.urlFor(posterPath: posterPath)
  }
  
}
