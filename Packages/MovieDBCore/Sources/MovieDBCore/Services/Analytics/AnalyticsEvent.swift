//
//  AnalyticsEvent.swift
//  
//
//  Created by Mouad Bj on 7/7/2023.
//

import Foundation

public protocol AnalyticsEvent {
  var name: String { get }
  var metadata: [String: String] { get }
}
