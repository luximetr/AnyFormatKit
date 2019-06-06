//
//  TextInputFormatter.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 18.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

public typealias FormattedTextValue = (formattedText: String, caretBeginOffset: Int)

/// Interface for formatter of TextInput, that allow change format of text during input
public protocol TextInputFormatter: TextFormatter {
  
  func formatInput(
    currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue
}
