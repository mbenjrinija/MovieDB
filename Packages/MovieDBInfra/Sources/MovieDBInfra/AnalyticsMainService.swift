//
//  AnalyticsMainService.swift
//  
//
//  Created by Mouad Bj on 7/7/2023.
//

import Foundation
import MovieDBCore

// sample implementation
public class AnalyticsMainService: AnalyticsService {
  
  public init() { }
  
  public func track(event: AnalyticsEvent) {
    // use an analytics manager here (e.g FireBase..)
    // ideally, the only file that should import the analytics library
    print(event.name)
  }
}
