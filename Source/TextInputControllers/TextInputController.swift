//
//  TextInputController.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 18.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

/// Controller for object, that conform to TextInput protocol, allow correct content during typing with formatter
open class TextInputController: TextInputDelegate {
  // MARK: - Fields
  /// Object, that conform to TextInput protocol
  open var textInput: TextInput? {
    didSet {
      textInput?.textInputDelegates.add(delegate: self)
      setPrefixToTextInput()
    }
  }
  /// Formatter, that apply format for text during editing
  open var formatter: TextInputFormatterProtocol? {
    didSet {
      setPrefixToTextInput()
    }
  }
  
  // MARK: - Init
  /**
   Initialize controller
   
   - Parameters:
     - textInput: The text input, for correcting input
  */
  public init(textInput: TextInput? = nil) {
    self.textInput = textInput
  }
  
  // MARK: - TextInputDelegate
  open func textInput(_ textInput: TextInput,
                 shouldChangeTextIn range: NSRange,
                 replacementText text: String) -> Bool {
    if let formattedPrefix = formattedPrefix,
      !formattedPrefix.isEmpty,
      range.location < formattedPrefix.count {
      return false
    }
    if let formatter = formatter {
      let replacementFiltered = text.filter(regex: formatter.allowedSymbolsRegex)
      let result = formatter.formatInput(currentText: textInput.content ?? "", range: range, replacementString: replacementFiltered)
      textInput.content = result.formattedText
      if let cursorLocation = textInput.position(from: textInput.beginningOfDocument, offset: result.caretBeginOffset) {
        textInput.selectedTextRange = textInput.textRange(from: cursorLocation, to: cursorLocation)
      }
      return false
    }
    return true
  }
  
  open func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool {
    return true
  }
    
  open func textInputDidBeginEditing(_ textInput: TextInput) {
    if let formatter = formatter {
      formatter.didBeginEditing(textInput)
    }
  }
  
  open func textInputShouldEndEditing(_ textInput: TextInput) -> Bool {
    return true
  }
  
  open func textInputDidEndEditing(_ textInput: TextInput) {
  }
  
  // MARK: - Public
  open func unformattedText() -> String? {
    guard let textInput = textInput else { return nil }
    if let formatter = formatter {
      return formatter.unformattedText(from: textInput.content)
    } else {
      return textInput.content
    }
  }
  
  open func setAndFormatText(_ text: String?) {
    guard let textInput = textInput else { return }
    if let formatter = formatter {
      textInput.content = formatter.formattedText(from: text)
    } else {
      textInput.content = text
    }
  }
}

// MARK: - Private
private extension TextInputController {
  /// Set and format current prefix
  func setPrefixToTextInput() {
    if let formattedPrefix = formatter?.formattedPrefix {
      textInput?.content = formattedPrefix
    }
  }
  
  var formattedPrefix: String? {
    return formatter?.formattedPrefix
  }
}
