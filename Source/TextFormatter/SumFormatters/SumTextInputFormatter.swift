//
//  SumTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

class SumTextInputFormatter: SumTextFormatter, TextInputFormatterProtocol {
//  var prefix: String?
  
  var formattedPrefix: String?
  
  var allowedSymbolsRegex: String?
  
  func shouldChangeTextIn(textInput: TextInput, range: NSRange, replacementString text: String) -> Bool {
    return false
  }
  
  
}
