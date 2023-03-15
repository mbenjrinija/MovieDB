//
//  RemoteModel.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import Foundation

protocol RemoteModel {
  associatedtype Model
  // transform from a remote model to an application domain model
  func transform() -> Model
}
