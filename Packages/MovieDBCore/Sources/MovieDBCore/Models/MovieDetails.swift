//
//  MovieDetails.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

public struct MovieDetails {
  public let id: Int
  public let title: String
  public let releaseDate: String?
  public let genres: [MovieGenre]?
  public let overview: String?
  public let popularity: Double?
  public let runtime: Int?
  public let voteAverage: Double?
  public let posterPath: String?
  public let backdropPath: String?
  
  public init(id: Int, title: String, releaseDate: String?, genres: [MovieGenre]?, overview: String?, popularity: Double?, runtime: Int?, voteAverage: Double?, posterPath: String?, backdropPath: String?) {
    self.id = id
    self.title = title
    self.releaseDate = releaseDate
    self.genres = genres
    self.overview = overview
    self.popularity = popularity
    self.runtime = runtime
    self.voteAverage = voteAverage
    self.posterPath = posterPath
    self.backdropPath = backdropPath
  }
}

