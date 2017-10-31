//
//  String+Extension.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 23.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

// MARK: - String extension
extension String {
  /**
   Filter string with given regular expression
   
   - Parameters:
     - regex: optional regular expression, that use for filter all symbols, that don't satisfy the RegEx
   
   - Returns: optional filtered string with symbols, that satify to RegEx
  */
  func filter(regex: String?) -> String {
    guard let regex = regex else { return self }
    let regexPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let filteredCharacters = characters.filter { (character) -> Bool in
      regexPredicate.evaluate(with: String(character))
    }
    return String(filteredCharacters)
  }
  
  /**
   Find and return character in string by index
   
   - Parameters:
     - index: integer value, of character, that need to find
   
   - Returns: found character or nil
  */
  func characterAt(_ index: Int) -> Character? {
    guard index < characters.count else { return nil }
    return self[self.index(self.startIndex, offsetBy: index)]
  }
  
  /// Lenght of string
  var length: Int {
    return self.characters.count
  }
}
