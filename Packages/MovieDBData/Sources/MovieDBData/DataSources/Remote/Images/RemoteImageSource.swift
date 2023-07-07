//
//  RemoteImageSource.swift
//  
//
//  Created by Mouad Bj on 6/7/2023.
//

import Foundation

public protocol RemoteImageSource {
  func loadImage(from url: URL) async throws -> Data
}

public struct RemoteImageSourceMain: RemoteImageSource {
  let session: URLSession
    
  public init(session: URLSession) {
    self.session = session
  }
  
  public func loadImage(from url: URL) async throws -> Data {
    // request a resized image for a better performance
    let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
    guard let url = urlComponents?.url else { throw ImageLoaderError.urlError }
    return try await session.dataTaskPublisher(for: url)
      .mapData()
      .eraseToAnyPublisher()
      .async()
  }
  
}

enum ImageLoaderError: Error {
  case urlError
}
