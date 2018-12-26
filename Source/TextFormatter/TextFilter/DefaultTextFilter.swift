//
//  DefaultTextFilter.swift
//  AnyFormatKit
//
//  Created by branderstudio on 12/26/18.
//  Copyright © 2018 branderstudio. All rights reserved.
//

import Foundation

open class DefaultTextFilter: TextFilter {
  
  // MARK: - Private variables
  
  public var allowedSymbolsRegex: String = ""
  
  // MARK: - Life cycle
  
  public init(allowedSymbolsRegex: String = "[^\(DefaultTextFormatter.Constants.defaultPatternSymbol)]") {
    self.allowedSymbolsRegex = allowedSymbolsRegex
  }
  
  open func filter(string: String) -> String {
    let regexPredicate = NSPredicate(format: "SELF MATCHES %@", allowedSymbolsRegex)
    let filteredCharacters = string.filter { (character) -> Bool in
      regexPredicate.evaluate(with: String(character))
    }
    return String(filteredCharacters)
  }
}
