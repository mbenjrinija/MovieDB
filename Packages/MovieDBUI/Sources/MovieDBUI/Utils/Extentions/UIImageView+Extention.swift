//
//  UIImageView+Extention.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import UIKit

extension UIImageView {
  
  // basic implementation for showcase, a production app should have a more robust solution
  func load(url: URL?, placeholder: UIImage?, cache: URLCache? = nil) {
    guard let url else { return }
    let cache = cache ?? URLCache.shared
    let request = URLRequest(url: url)
    
    if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
      DispatchQueue.main.async {
        self.image = image
      }
    } else {
      self.image = placeholder
      // for demo convenience only
      // normally this should be done using the NetworkManager protocol and not through urlsession
      URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
        guard let data = data, let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode, let image = UIImage(data: data) else { return }
        
        let cachedData = CachedURLResponse(response: httpResponse, data: data)
        cache.storeCachedResponse(cachedData, for: request)
        DispatchQueue.main.async {
          self?.image = image
        }
      }.resume()
    }
  }
}
