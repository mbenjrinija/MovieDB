//
//  File.swift
//  
//
//  Created by Mouad Bj on 7/7/2023.
//

import Foundation

public struct MovieGenre: Codable {
  public let id: Int?
  public let name: String?
  
  public init(id: Int?, name: String?) {
    self.id = id
    self.name = name
  }
  
}
