//
//  PaginatedList.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

struct PaginatedList<Item: Hashable> {
  var page: Int?
  var results: [Item]?
  let totalPages, totalResults: Int?
  
  func nextPage() -> Int? {
    guard let page, let totalPages else { return nil }
    return page < totalPages ? page + 1 : nil
  }
  
  mutating func reset(items: [Item]? = nil) {
    self.page = 1
    self.results = items
  }
  
  mutating func onNext(page: Int, items: [Item]) {
    self.page = page
    self.results?.append(contentsOf: items)
    // sometime duplicate items can show up while
    // loading more pages due to a newly added item
    self.results = self.results?.uniqued()
  }
}
