//
//  RemoteImageSource.swift
//  
//
//  Created by Mouad Bj on 6/7/2023.
//

import Foundation

public protocol RemoteImageSource: RemoteDataSource {
  func loadImage(from url: URL) async throws -> Data
}

public struct RemoteImageSourceMain: RemoteImageSource {
  public var networkManager: NetworkManager

  public init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }
  
  public func loadImage(from url: URL) async throws -> Data {
    // request a resized image for a better performance
    let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
    guard let url = urlComponents?.url else { throw ImageLoaderError.urlError }
    return try await networkManager.dataTaskPublisher(for: url).async()
  }
  
}

enum ImageLoaderError: Error {
  case urlError
}
