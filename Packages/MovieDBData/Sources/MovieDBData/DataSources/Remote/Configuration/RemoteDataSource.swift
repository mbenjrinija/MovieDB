//
//  ApiRepository.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation
import Combine

public protocol RemoteDataSource {
  var networkManager: NetworkManager { get }
}

// for convenience
extension RemoteDataSource {
  func fetch<Value>(call: RemoteCall) -> AnyPublisher<Value, Error> where Value: Decodable {
    return networkManager.fetch(call: call)
  }
}
