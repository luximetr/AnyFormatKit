//
//  PlaceholderTextFormatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class PlaceholderTextFormatter: DefaultTextFormatter {
  
  public override func format(_ unformattedText: String?) -> String? {
    guard let fromSuper = super.format(unformattedText), !fromSuper.isEmpty else { return textPattern }
    guard fromSuper.count <= textPattern.count else { return fromSuper }
    
    let start = textPattern.index(textPattern.startIndex, offsetBy: fromSuper.count)
    let end = textPattern.endIndex
    let ending = textPattern[start..<end]
    
    return fromSuper + ending
  }
  
  public override func unformat(_ formattedText: String?) -> String? {
    return super.unformat(formattedText)
  }
}
