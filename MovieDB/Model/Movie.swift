//
//  Movie.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation

struct Movie: Hashable {
  let id: Int?
  let title, originalTitle, posterPath, releaseDate: String?
  let voteAverage: Double?
}
