//
//  DIContainer+Config.swift
//  MovieDB
//
//  Created by Mouad Bj on 4/7/2023.
//

import Foundation
import MovieDBData
import MovieDBUI
import MovieDBCore
import MovieDBInfra

/// DI Configuration (could be splitted into multiple files)
extension DIContainer {
  
  static func configure() -> DIContainer {
    let urlSession: URLSession = .default
    
    // configure DataSources
    Self.default
      .register(.Data.Source.Remote.networkManager) { _ in
        NetworkManagerMain(session: urlSession)
      }.register(.Data.Source.Remote.movies) { resolver in
        MoviesRemoteDataSourceMain(
          networkManager: try resolver.resolve(.Data.Source.Remote.networkManager))
      }.register(.Data.Source.Remote.images) { resolver in
        RemoteImageSourceMain(
          networkManager: try resolver.resolve(.Data.Source.Remote.networkManager))
      }.register(.Data.Source.Local.images) { _ in
        LocalImageSourceMemory()
      }
    
    // configure Repositories
    Self.default
      .register(.Data.Repository.Remote.movies) { resolver in
        MoviesRepositoryMain(remoteMovies: try resolver.resolve(.Data.Source.Remote.movies))
      }.register(.Data.Repository.images) { resolver in
        ImageRepositoryMain(
          localImageSource: try resolver.resolve(.Data.Source.Local.images),
          remoteImageSource: try resolver.resolve(.Data.Source.Remote.images))
      }
    
    // configure Domain Intractors
    Self.default
      .register(.Domain.Interactor.movies) { resolver in
        MovieInteractorMain(moviesRepository: try resolver.resolve(.Data.Repository.Remote.movies))
      }.register(.Domain.Interactor.analytics) { _ in
        AnalyticsMainService()
      }
    return Self.default
  }
  
}
