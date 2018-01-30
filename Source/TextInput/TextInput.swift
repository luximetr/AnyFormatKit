//
//  TextInput.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 09.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

/// Interface for text input
public protocol TextInput: UITextInput {
  /// Current string in text input
  var content: String? { set get }
  
  /// Current attributed string in text input
  var attributedContent: NSAttributedString? { set get }
  
  /// Delegate for common TextInput methods
  weak var textInputDelegate: TextInputDelegate? { set get }
}
