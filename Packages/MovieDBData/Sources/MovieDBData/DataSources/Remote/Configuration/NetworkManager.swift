//
//  NetworkManager.swift
//  
//
//  Created by Mouad Bj on 11/7/2023.
//

import Foundation
import Combine

public protocol NetworkManager {
  func fetch<Value>(call: RemoteCall) -> AnyPublisher<Value, Error> where Value: Decodable
  func dataTaskPublisher(for url: URL) -> AnyPublisher<Data, Error>
}

// sample implementation, note that URLSession in used only in this class
// making it easily swappable if needed
public class NetworkManagerMain: NetworkManager {
  let session: URLSession
  
  public init(session: URLSession) {
    self.session = session
  }
  
  public func fetch<Value>(call: RemoteCall) -> AnyPublisher<Value, Error> where Value : Decodable {
    do {
      let request = try call.request()
      return session
        .dataTaskPublisher(for: request)
        .decodeData()
    } catch let error {
      return Fail<Value, Error>(error: error).eraseToAnyPublisher()
    }
  }
  
  public func dataTaskPublisher(for url: URL) -> AnyPublisher<Data, Error> {
    return session.dataTaskPublisher(for: url)
      .mapData()
      .eraseToAnyPublisher()
  }
  
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
  func mapData(successCodes: HTTPCodes = .success) -> AnyPublisher<Data, Error> {
    tryMap { data, response in
      // extract status code
      guard let code = (response as? HTTPURLResponse)?.statusCode else {
        throw APIError.unexpectedResponse
      }
      // throw if status code is out of success range
      guard successCodes.contains(code) else {
        let json = String(data: data, encoding: .utf8)
        throw APIError.httpCode(code, json ?? "No data in body")
      }
      // return data object
      return data
    }.eraseToAnyPublisher()
  }
  
  func decodeData<T>(successCodes: HTTPCodes = .success)
  -> AnyPublisher<T, Error> where T: Decodable {
    mapData(successCodes: successCodes)
      .decode(type: T.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}


extension URLSession {
  public static var `default`: URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 60
    configuration.timeoutIntervalForResource = 120
    configuration.waitsForConnectivity = true
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    configuration.urlCache = .shared
    return URLSession(configuration: configuration)
  }
}
