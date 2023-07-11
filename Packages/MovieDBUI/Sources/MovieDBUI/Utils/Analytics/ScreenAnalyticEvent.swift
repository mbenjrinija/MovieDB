//
//  ScreenAnalyticEvent.swift
//  
//
//  Created by Mouad Bj on 7/7/2023.
//

import Foundation
import MovieDBCore

enum ScreenAnalyticEvent: AnalyticsEvent {
  case screenViewed(name: String)
  
  var name: String {
    switch self {
    case .screenViewed(name: let name):
      return "screen_viewed_\(name)"
    }
  }
  
  var metadata: [String : String] {
    get { return [:] }
  }
  
}

// convenience function
extension AnalyticsService {
  func sendScreen(event: ScreenAnalyticEvent) {
    track(event: event)
  }
}
