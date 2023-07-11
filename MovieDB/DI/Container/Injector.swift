//
//  Injector.swift
//  MovieDB
//
//  Created by Mouad Bj on 4/7/2023.
//

import Foundation

/// Dependency Injector
protocol Injector {
  func register<Value>(_ injectable: Injectable<Value>, resolve: (Injector) throws -> Value) -> Self
  func resolve<Value>(_ injectable: Injectable<Value>) throws -> Value
}

enum InjectionError: Error {
  case unregistered(String)
}
