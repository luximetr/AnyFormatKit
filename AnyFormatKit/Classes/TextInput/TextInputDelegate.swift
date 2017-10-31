//
//  TextInputDelegate.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 10.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

/// Protocol for delegates of TextInput objects during editing proccess
public protocol TextInputDelegate: class {
  /**
   Asks the delegate if editing should begin in the specified text input.
   
   - Parameters:
     - textInput: The text input in which editing is about to begin.

   - Retunrs: true if editing should begin or false if it should not.
  */
  func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool
  
  /**
   Tells the delegate that editing began in the specified text input.
   
   - Parameters:
     - textInput: The text input in which an editing session began.
  */
  func textInputDidBeginEditing(_ textInput: TextInput)
  
  /**
   Asks the delegate if editing should stop in the specified text input.
   
   - Parameters:
     - textInput: The text input in which editing is about to end.
   
   - Returns: true if editing should stop or false if it should continue.
  */
  func textInputShouldEndEditing(_ textInput: TextInput) -> Bool
  
  /**
   Tells the delegate that editing stopped for the specified text input.
   
   - Parameters:
     - textInput: The text input for which editing ended.
  */
  func textInputDidEndEditing(_ textInput: TextInput)
  
  /**
   Asks the delegate if the specified text should be changed.
   
   - Parameters:
     - textInput: The text input containing the text.
     - range: The range of characters to be replaced.
     - text: The replacement string for the specified range. During typing, this parameter normally contains only the single new character that was typed, but it may contain more characters if the user is pasting text. When the user deletes one or more characters, the replacement string is empty.
   
   - Returns: true if the specified text range should be replaced; otherwise, false to keep the old text.
  */
  func textInput(_ textInput: TextInput,
                shouldChangeTextIn range: NSRange,
                replacementText text: String) -> Bool
}

// Default implementation
/// Extension for making methods optional
public extension TextInputDelegate {
  func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool { return true }
  func textInputDidBeginEditing(_ textInput: TextInput) {}
  func textInputShouldEndEditing(_ textInput: TextInput) -> Bool { return true }
  func textInputDidEndEditing(_ textInput: TextInput) {}
  func textInput(_ textInput: TextInput,
                 shouldChangeTextIn range: NSRange,
                 replacementText text: String) -> Bool { return true }
}
