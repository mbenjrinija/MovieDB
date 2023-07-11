//
//  MoviesListRemoteModel.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//
// this model used to code/decode json
// should only be used in the remote data source layer
//

import Foundation
import MovieDBCore

// MARK: - MoviesListRemoteModel
struct MoviesListRemoteModel: Codable {
    let page: Int?
    let results: [MovieRemoteModel]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Transformation to Domain Models
extension MoviesListRemoteModel: RemoteModel {
  func transform() -> PaginatedList<Movie> {
    PaginatedList(
      page: page,
      // ignore failed transformations
      results: results?.compactMap { try? $0.transform() },
      totalPages: totalPages,
      totalResults: totalResults)
  }
}
