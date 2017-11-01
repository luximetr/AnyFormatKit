//
//  TextInputViewDelegate.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 13.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

/// Protocol for delegates of TextView's special methods
public protocol TextInputViewDelegate: class {
  /**
   Tells the delegate that the text or attributes in the specified text view were changed by the user.
   
   - Parameters:
     - textInput: The text input containing the changes.
  */
  func textInputDidChange(_ textInput: TextInputView)
  
  /**
   Tells the delegate that the text selection changed in the specified text view.
   
   - Parameters:
     - textInput: The text input whose selection changed.
  */
  func textInputDidChangeSelection(_ textInput: TextInputView)
  
  /**
   Asks the delegate if the specified text input should allow the specified type of user interaction with the provided text attachment in the given range of text.
   
   - Parameters:
     - textInput: The text input containing the text attachment.
     - textAttachment: The text attachment.
     - characterRange: The character range containing the text attachment.
     - interaction: The type of interaction that is occurring (for possible values, see UITextItemInteraction).
   
   - Returns: true if interaction with the text attachment should be allowed; false if interaction should not be allowed.
  */
  @available(iOS 10.0, *)
  func textInput(_ textInput: TextInputView,
                 shouldInteractWith textAttachment: NSTextAttachment,
                 in characterRange: NSRange,
                 interaction: UITextItemInteraction) -> Bool
  
  /**
   Asks the delegate if the specified text view should allow the specified type of user interaction with the given URL in the given range of text.
   
   - Parameters:
     - textInput: The text input containing the text attachment.
     - URL: The URL to be processed.
     - characterRange: The character range containing the URL.
     - interaction: The type of interaction that is occurring (for possible values, see UITextItemInteraction).
   
   - Returns: true if interaction with the URL should be allowed; false if interaction should not be allowed.
  */
  @available(iOS 10.0, *)
  func textInput(_ textInput: TextInputView,
                 shouldInteractWith URL: URL,
                 in characterRange: NSRange,
                 interaction: UITextItemInteraction) -> Bool
}

// Default implementation
/// Extension for making methods optional
public extension TextInputViewDelegate {
  func textInputDidChange(_ textInput: TextInputView) {}
  func textInputDidChangeSelection(_ textInput: TextInputView) {}
  @available(iOS 10.0, *)
  func textInput(_ textInput: TextInputView,
                 shouldInteractWith textAttachment: NSTextAttachment,
                 in characterRange: NSRange,
                 interaction: UITextItemInteraction) -> Bool { return true }
  @available(iOS 10.0, *)
  func textInput(_ textInput: TextInputView,
                 shouldInteractWith URL: URL,
                 in characterRange: NSRange,
                 interaction: UITextItemInteraction) -> Bool { return true }
}
