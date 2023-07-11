//
//  MovieRemoteModel.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//
// this model used to code/decode json
// should only be used in the remote data source layer
//

import Foundation
import MovieDBCore

// MARK: - MovieRemoteModel
struct MovieRemoteModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, title: String?
    let releaseDate: Date?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Transformation to Domain Models
extension MovieRemoteModel: RemoteModel {
  func transform() throws -> Movie {
    Movie(id: try unwrap(id),
          title: try unwrap(title),
          originalTitle: try unwrap(originalTitle),
          posterPath: try unwrap(posterPath),
          releaseDate: try unwrap(releaseDate),
          voteAverage: voteAverage)
  }
}
