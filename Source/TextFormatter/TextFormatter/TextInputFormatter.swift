//
//  TextInputFormatter.swift
//
//  Created by Oleksandr Orlov on 18.10.2017.
//  Copyright © 2017 Oleksandr Orlov. All rights reserved.
//

import Foundation

/// Interface for formatter of TextInput, that allow change format of text during input
public protocol TextInputFormatter {
  
  func formatInput(
    currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue
}
