//
//  PaginatedList.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

struct PaginatedList<Item> {
  let page: Int?
  let results: [Item]?
  let totalPages, totalResults: Int?
}
