//
//  Movie.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation

public struct Movie: Hashable {
  public let id: Int?
  public let title, originalTitle, posterPath, releaseDate: String?
  public let voteAverage: Double?
  
  public init(id: Int?, title: String?, originalTitle: String?, posterPath: String?, releaseDate: String?, voteAverage: Double?) {
    self.id = id
    self.title = title
    self.originalTitle = originalTitle
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.voteAverage = voteAverage
  }
}
