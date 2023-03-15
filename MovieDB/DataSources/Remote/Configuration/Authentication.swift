//
//  Authentication.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation

// no auth neeed in this project
// this file is just for showcase

protocol AuthStrategy {
  func patch(params: [String: String]?) -> [String: String]?
  func patch(headers: [String: String]?) -> [String: String]?
}

struct AuthDefault: AuthStrategy {

  func patch(params: [String: String]?) -> [String: String]? {
    var patchedParams = params ?? [:]
    patchedParams["api_key"] = Constants.API.apiKey
    return patchedParams
  }

  func patch(headers: [String: String]?) -> [String: String]? {
    return headers
  }
}
