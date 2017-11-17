//
//  AttributedStringConstructor.swift
//  LightTextInput
//
//  Created by BRANDERSTUDIO on 30.10.2017.
//

import Foundation

class AttributedStringConstructor {
  // MARK: - Fields
  /// Dictionary of attributes with ranges, separate attributes apply to relevant range
  private var attributesWithRange = [NSRange: [NSAttributedStringKey: Any]]()
  
  /**
   Create string with attributes, that contains attributes from dictionaries
   
   - Parameters:
     - newValue: New string, that will set
   
   - Returns: String with attributes, that contains in attributes dictionaries
   */
  func attributedStringWithAttributes(
    newValue: String?, commonAttributes: [String: Any]?) -> NSAttributedString? {
    guard let newValue = newValue else { return nil }
    var newAttributedValue = NSMutableAttributedString(
      string: newValue,
      attributes: convertToAttribute(dictionary: commonAttributes))
    appendAttributesWithRange(toString: &newAttributedValue, newValue: newValue)
    return newAttributedValue
  }
  
  /**
   Add attributes for range
   
   - Parameters:
     - newAttributes: Dictionary of attributes with values
     - range: Range in string, that will format will attributes
  */
  open func addAttributes(_ newAttributes: [NSAttributedStringKey: Any], range: NSRange) {
    for (attributedKey, value) in newAttributes {
      if attributesWithRange[range] != nil {
        attributesWithRange[range]?[attributedKey] = value
      } else {
        attributesWithRange[range] = [attributedKey: value]
      }
    }
  }
  
  /**
   Remove attribute for range
   
   - Parameters:
     - attribute: Attribute, that will remove
     - range: Range, that was set with attribute, range is a key for remove
  */
  open func removeAttribute(_ attribute: NSAttributedStringKey, range: NSRange) {
    if attributesWithRange[range] != nil {
      attributesWithRange[range]?.removeValue(forKey: attribute)
    } else {
      attributesWithRange.removeValue(forKey: range)
    }
  }
  
  /// Remove all attributes
  open func removeAllAttributes() {
    attributesWithRange.removeAll()
  }
}

// MARK: - Private
private extension AttributedStringConstructor {
  /**
   Append attributesWithRange to string, that get in parameters
   
   - Parameters:
     - toString: Inout mutable attributed string, that will modified
     - newValue: New string, that will set to changable string
   */
  func appendAttributesWithRange(toString: inout NSMutableAttributedString,
                                 newValue: String) {
    for (range, attributes) in attributesWithRange {
      if range.location <= newValue.count {
        let limitedRangeLength = range.upperBound > newValue.count ?
          newValue.count - range.location : range.length
        let limitedRange = NSRange(location: range.location, length: limitedRangeLength)
        toString.addAttributes(attributes, range: limitedRange)
      }
    }
  }
  
  /**
   Convert string to attributedStringKey dictionaty
   
   - Parameters:
     - dictionary: Dictionary to convert
   
   - Returns: Converted dictionary with attributes
  */
  func convertToAttribute(dictionary: [String: Any]?) -> [NSAttributedStringKey: Any]? {
    guard let dictionary = dictionary else { return nil }
    let convertedAttributes = Dictionary(uniqueKeysWithValues:
      dictionary.lazy.map { (NSAttributedStringKey($0.key), $0.value) }
    )
    return convertedAttributes
  }
}
