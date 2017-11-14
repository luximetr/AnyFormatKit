//
//  SumTextFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

public class SumTextFormatter: TextFormatterProtocol {
  public var allowsFloats: Bool {
    set {
      numberFormatter.allowsFloats = newValue
      
    }
    get { return numberFormatter.allowsFloats }
  }
  public var prefix: String?
  public var suffix: String?
  
  public var decimalSeparator: String {
    set { numberFormatter.currencyDecimalSeparator = newValue }
    get { return numberFormatter.currencyDecimalSeparator }
  }
  public var groupingSeparator: String {
    set { numberFormatter.currencyGroupingSeparator = newValue }
    get { return numberFormatter.currencyGroupingSeparator }
  }
  
  public var minimumIntegerDigits: Int {
    set { numberFormatter.minimumIntegerDigits = newValue }
    get { return numberFormatter.minimumIntegerDigits }
  }
  public var maximumIntegerDigits: Int {
    set { numberFormatter.maximumIntegerDigits = newValue }
    get { return numberFormatter.maximumIntegerDigits }
  }
  public var minimumFractionDigits: Int {
    set { numberFormatter.minimumFractionDigits = newValue }
    get { return numberFormatter.minimumFractionDigits }
  }
  public var maximumFractionDigits: Int {
    set { numberFormatter.maximumFractionDigits = newValue }
    get { return numberFormatter.maximumFractionDigits }
  }
  
  public var minusSign: String {
    set { numberFormatter.minusSign = newValue }
    get { return numberFormatter.minusSign }
  }
  public var groupingSize: Int {
    set { numberFormatter.groupingSize = newValue }
    get { return numberFormatter.groupingSize }
  }
  
  internal let numberFormatter = NumberFormatter()
  
  public init() {
    numberFormatter.numberStyle = .currency
    numberFormatter.currencyCode = String()
    numberFormatter.currencySymbol = String()
  }
  
  public func formattedText(from unformatted: String?) -> String? {
    guard
      let unformatted = unformatted,
      let doubleValue = Double(unformatted) else {
        return nil
    }
    let number = NSNumber(floatLiteral: doubleValue)
    return numberFormatter.string(from: number)
  }
  
  public func unformattedText(from formatted: String?) -> String? {
    guard
      let formatted = formatted,
      let number = numberFormatter.number(from: formatted) else {
      return nil
    }
    return number.stringValue
  }
}
