//
//  SumTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

public class SumTextInputFormatter: SumTextFormatter, TextInputFormatterProtocol {
    
    public var prefix: String?
    
//  var prefix: String?
  
  public var formattedPrefix: String?
  
  public var allowedSymbolsRegex: String?
  
  public func shouldChangeTextIn(textInput: TextInput, range: NSRange, replacementString text: String) -> Bool {
    return false
  }
  
  
}
