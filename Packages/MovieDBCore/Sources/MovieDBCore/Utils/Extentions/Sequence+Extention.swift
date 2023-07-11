//
//  Sequence+Extention.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import Foundation

extension Sequence where Element: Hashable {
  public func uniqued() -> [Element] {
    var set = Set<Element>()
    return filter { set.insert($0).inserted }
  }
}
