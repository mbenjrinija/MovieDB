//
//  Loadable.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

public enum Loadable<T> {
  case notLoaded
  case loading(T?)
  case failed(T?, Error)
  case loaded(T)
  
  public var value: T? {
    switch self {
    case .loading(let latest): return latest
    case .failed(let latest, _): return latest
    case .loaded(let value): return value
    default: return nil
    }
  }
  
  public var error: Error? {
    switch self {
    case .failed(_, let error): return error
    default: return nil
    }
  }
  
  public var isLoading: Bool {
    switch self {
    case .loading(_): return true
    default: return false
    }
  }
  
}
