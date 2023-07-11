//
//  File.swift
//  
//
//  Created by Mouad Bj on 6/7/2023.
//

import Foundation

public protocol ImageRepository {
  func loadImage(from urlString: String?) async -> Data?
}

public struct ImageRepositoryMain: ImageRepository {
  let localImageSource: LocalImageSource
  let remoteImageSource: RemoteImageSource

  public init(localImageSource: LocalImageSource, remoteImageSource: RemoteImageSource) {
    self.localImageSource = localImageSource
    self.remoteImageSource = remoteImageSource
  }
  
  public func loadImage(from urlString: String?) async -> Data? {
    guard let urlString, let url = URL(string: urlString) else { return nil }
    // load image from local data source if exists
    if let image = await localImageSource.loadImage(for: url) {
      return image
    }
    // if not, load image from remote data source
    if let image = try? await remoteImageSource.loadImage(from: url) {
      await localImageSource.saveImage(imageData: image, url: url)
      return image
    }
    return nil
  }
  
}
