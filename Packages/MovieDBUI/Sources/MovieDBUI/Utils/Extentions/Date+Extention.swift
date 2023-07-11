//
//  File.swift
//  
//
//  Created by Mouad Bj on 11/7/2023.
//

import Foundation

extension Date {
  
  func toString(format: String = "dd/MM/yyyy") -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
  
}
