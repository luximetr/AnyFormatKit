//
//  TextInputFormatter.swift
//  AnyFormatKit2
//
//  Created by branderstudio on 11/14/18.
//  Copyright © 2018 branderstudio. All rights reserved.
//

import Foundation

public typealias FormattedTextValue = (formattedText: String, caretBeginOffset: Int)

public protocol TextInputFormatter: TextFormatter {
  
  /**
   Method, that allow correct character by character input with specified format
   
   - Parameters:
   - textInput: Object, that conform to TextInput protocol and represent input field with correcting content
   - range: Range, that determine which symbols must to be replaced
   - replacementString: String, that will replace old content in determined range
   
   - Returns: Always return false (correct of textInput's content in method's body)
   */
  func formatInput(
    currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue
}
