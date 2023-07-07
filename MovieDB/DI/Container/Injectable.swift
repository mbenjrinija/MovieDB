//
//  Injectable.swift
//  MovieDB
//
//  Created by Mouad Bj on 4/7/2023.
//

import Foundation
import MovieDBData
import MovieDBCore

struct Injectable<T> {
  var identifier: String
  init(identifier: String) { self.identifier = identifier }
  init() { self.init(identifier: "\(T.self)") }
}

// allow nesting/shortNames for convenience reasons
// swiftlint:disable nesting
/// Dependency Graph Skeleton
extension Injectable {
  struct Domain {
    struct Interactor { }
  }
  struct Data {
    struct DataSource {
      struct Remote { }
      struct Local { }
    }
    struct Repository {
      struct Remote { }
    }
  }
}
// swiftlint:enable nesting

extension Injectable.Domain.Interactor {
  static var movies: Injectable<MoviesInteractor> { .init() }
  static var analytics: Injectable<AnalyticsService> { .init() }
}

extension Injectable.Data.DataSource.Local {
  static var images: Injectable<LocalImageSource> { .init() }
}

extension Injectable.Data.DataSource.Remote {
  static var movies: Injectable<MoviesRemoteDataSource> { .init() }
  static var images: Injectable<RemoteImageSource> { .init() }
}
extension Injectable.Data.Repository.Remote {
  static var movies: Injectable<MoviesRepository> { .init() }
}
extension Injectable.Data.Repository {
  static var images: Injectable<ImageRepository> { .init() }
}

