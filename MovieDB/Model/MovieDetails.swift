//
//  MovieDetails.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

struct MovieDetails {
  let id: Int?
  let title: String?
  let releaseDate: String?
  let genres: [MovieGenre]?
  let overview: String?
  let popularity: Double?
  let runtime: Int?
  let voteAverage: Double?
  let posterPath: String?
  let backdropPath: String?
}

// MARK: - MovieGenre
struct MovieGenre: Codable {
  let id: Int?
  let name: String?
}
