//
//  TextFormatter.swift
//  AnyFormatKit2
//
//  Created by branderstudio on 11/14/18.
//  Copyright © 2018 branderstudio. All rights reserved.
//

import Foundation

public protocol TextFormatter {
  /**
   Formatting text with current textPattern
   
   - Parameters:
   - unformatted: String, that need to be convert with current textPattern
   
   - Returns: Formatted text with current textPattern
   */
  func format(text: String) -> String
  
  /**
   Method for convert string, that sutisfy current textPattern, into unformatted string
   
   - Parameters:
   - formatted: String, that will convert
   
   - Returns: string converted into unformatted with current textPattern
   */
  func unformat(from formatted: String) -> String
}
