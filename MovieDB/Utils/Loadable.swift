//
//  Loadable.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

enum Loadable<T> {
  case notLoaded
  case loading(T?)
  case failed(T?, Error)
  case loaded(T)
  
  var value: T? {
    switch self {
    case .loading(let latest): return latest
    case .failed(let latest, _): return latest
    case .loaded(let value): return value
    default: return nil
    }
  }
  
  var error: Error? {
    switch self {
    case .failed(_, let error): return error
    default: return nil
    }
  }
}
