//
//  PaginatedList.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

public struct PaginatedList<Item: Hashable> {
  public var page: Int?
  public var results: [Item]?
  public let totalPages, totalResults: Int?
  
  public init(page: Int? = nil, results: [Item]? = nil, totalPages: Int?, totalResults: Int?) {
    self.page = page
    self.results = results
    self.totalPages = totalPages
    self.totalResults = totalResults
  }
  
  public func nextPage() -> Int? {
    guard let page, let totalPages else { return nil }
    return page < totalPages ? page + 1 : nil
  }
  
  public mutating func reset(items: [Item]? = nil) {
    self.page = 1
    self.results = items
  }
  
  public mutating func onNext(page: Int, items: [Item]) {
    self.page = page
    self.results?.append(contentsOf: items)
    // sometime duplicate items can show up while
    // loading more pages due to a newly added item
    self.results = self.results?.uniqued()
  }
}
