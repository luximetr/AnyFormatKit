//
//  TextInputFieldDelegate.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 13.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

/// Protocol for delegates of TextField's special methods
public protocol TextInputFieldDelegate: class {
  /**
   Asks the delegate if the text input's current contents should be removed.
   
   - Parameters:
     - textInput: The text input containing the text.
   
   - Retunrs: true if the text input's contents should be cleared; otherwise, false.
  */
  func textInputShouldClear(_ textInput: TextInputField) -> Bool
  
  /**
   Asks the delegate if the text input should process the pressing of the return button.
   
   - Parameters:
     - textInput: The text input whose return button was pressed.
   
   - Returns: true if the text field should implement its default behavior for the return button; otherwise, false.
  */
  func textInputShouldReturn(_ textInput: TextInputField) -> Bool
  
  /**
   Tells the delegate that editing stopped for the specified text input.
   
   - Parameters:
     - textInput: The text input for which editing ended.
     - reason: The reason why editing ended. Use this field to determine whether to incorporate the text editing changes or abandon them.
  */
  @available(iOS 10.0, *)
  func textInputDidEndEditing(_ textInput: TextInputField, reason: UITextFieldDidEndEditingReason)
}

// Default implementation
/// Extension for making methods optional
public extension TextInputFieldDelegate {
  func textInputShouldClear(_ textInput: TextInputField) -> Bool { return true }
  func textInputShouldReturn(_ textInput: TextInputField) -> Bool { return true }
  @available(iOS 10.0, *)
  func textInputDidEndEditing(_ textInput: TextInputField, reason: UITextFieldDidEndEditingReason) {}
}
