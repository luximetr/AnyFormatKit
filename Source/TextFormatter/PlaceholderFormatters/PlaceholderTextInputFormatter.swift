//
//  PlaceholderTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class PlaceholderTextInputFormatter: DefaultTextInputFormatter {
  
  public override func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
    let fromSuper = super.formatInput(currentText: currentText, range: range, replacementString: text)
    
    return fromSuper
  }
  
}
