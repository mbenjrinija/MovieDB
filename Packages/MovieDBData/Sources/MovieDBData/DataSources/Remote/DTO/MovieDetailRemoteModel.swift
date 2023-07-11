//
//  MovieDetailRemoteModel.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation
import MovieDBCore

struct MovieDetailRemoteModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [MovieGenreRemoteModel]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - MovieGenre
struct MovieGenreRemoteModel: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Transformation to Domain Models
extension MovieDetailRemoteModel: RemoteModel {
  func transform() throws -> MovieDetails {
    MovieDetails(id: try unwrap(id),
                 title: try unwrap(title),
                 releaseDate: releaseDate,
                 genres: genres?.map{ $0.transform() },
                 overview: overview,
                 popularity: popularity,
                 runtime: runtime,
                 voteAverage: voteAverage,
                 posterPath: posterPath,
                 backdropPath: backdropPath)
  }
}

extension MovieGenreRemoteModel: RemoteModel {
  func transform() -> MovieGenre {
    MovieGenre(id: id, name: name)
  }
}
