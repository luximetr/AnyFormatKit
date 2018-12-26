//
//  TextFilter.swift
//  AnyFormatKit
//
//  Created by branderstudio on 12/26/18.
//  Copyright © 2018 branderstudio. All rights reserved.
//

import Foundation

public protocol TextFilter {
  var allowedSymbolsRegex: String { set get }
  func filter(string: String) -> String
}
