//
//  DIContainer.swift
//  MovieDB
//
//  Created by Mouad Bj on 4/7/2023.
//

import Foundation

/// Dependency Injection Container
class DIContainer: Injector {
  static var `default` = DIContainer()
  private var components = [String: Any]()
  private init() { }
  
  @discardableResult // for chaining
  func register<T>(_ injectable: Injectable<T>, resolve: (Injector) throws -> T) -> Self {
    do {
      components[injectable.identifier] = try resolve(self)
    } catch {
      fatalError(error.localizedDescription)
    }
    return self
  }
  
  func resolve<T>(_ injectable: Injectable<T>) throws -> T {
    try (components[injectable.identifier] as? T) ?? {
      throw InjectionError.unregistered(injectable.identifier)
    }()
  }
  
  func reset() {
    components.removeAll()
  }
}
