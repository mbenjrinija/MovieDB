//
//  AnalyticsService.swift
//  
//
//  Created by Mouad Bj on 7/7/2023.
//

import Foundation

public protocol AnalyticsService {
  func track(event: AnalyticsEvent)
}
