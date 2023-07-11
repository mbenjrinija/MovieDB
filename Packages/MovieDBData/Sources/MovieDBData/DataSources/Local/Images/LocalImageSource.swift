//
//  LocalImageSource.swift
//  
//
//  Created by Mouad Bj on 6/7/2023.
//

import Foundation

public protocol LocalImageSource {
  func loadImage(for url: URL) async -> Data?
  func saveImage(imageData: Data, url: URL) async
}


public class LocalImageSourceMemory: LocalImageSource {
  typealias Cache = NSCache<AnyObject, AnyObject>
  private lazy var rawImageCache: Cache = {
    let cache = Cache()
    cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
    return cache
  }()
  
  public init() { }
  
  // MARK: - implementation
  public func saveImage(imageData: Data, url: URL) async {
    cache(image: imageData, in: rawImageCache, for: url)
  }
  
  public func loadImage(for url: URL) async -> Data? {
    return from(cache: rawImageCache, for: url)
  }
  
  // MARK: - helpers
  func remove(for key: URL) async {
    rawImageCache.removeObject(forKey: key as AnyObject)
  }
  
  func removeAll() {
    rawImageCache.removeAllObjects()
  }
  
  func cache(image: Data, in cache: Cache, for key: URL) {
    cache.setObject(image as AnyObject, forKey: key as AnyObject)
  }
  
  func from(cache: Cache, for key: URL) -> Data? {
    cache.object(forKey: key as AnyObject) as? Data
  }
}
