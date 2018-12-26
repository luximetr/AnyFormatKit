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
  var textInput: TextInput?
  
  public var prefix: String? {
    didSet {
      setPrefixToTextInput()
    }
  }
  
  
  /// Formatter, that apply format for text during editing
  open var formatter: TextInputFormatter? {
    didSet {
      setPrefixToTextInput()
    }
  }
  
  public let observer = Observer<TextInputControllerObserver>()
  
  private let textFilter = DefaultTextFilter()
  
  public var allowedSymbolsRegex: String {
    set { textFilter.allowedSymbolsRegex = newValue }
    get { return textFilter.allowedSymbolsRegex }
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
      
      let replacementFiltered = textFilter.filter(string: text)
      let result = formatter.formatInput(currentText: textInput.text ?? "", range: range, replacementString: replacementFiltered)
      
      textInput.text = result.formattedText
      
      if let cursorLocation = textInput.position(from: textInput.beginningOfDocument,
                                                 offset: result.caretBeginOffset) {
        textInput.selectedTextRange = textInput.textRange(from: cursorLocation, to: cursorLocation)
      }
        notifyTextInputDidChangeText(textInput: textInput)
      return false
    }
    notifyTextInputDidChangeText(textInput: textInput)
    return true
  }
  
  open func textInputWasAskBeginEditing(_ textInput: TextInput) {
    notifyTextInputWasAskBeginEditing(textInput: textInput)
  }
  
  open func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool {
    notifyTextInputWillBeginEditing(textInput: textInput)
    return true
  }
    
  open func textInputDidBeginEditing(_ textInput: TextInput) {
//    if let formatter = formatter {
//      formatter.didBeginEditing(textInput)
//    }
    notifyTextInputDidBeginEditing(textInput: textInput)
  }
  
  open func textInputShouldEndEditing(_ textInput: TextInput) -> Bool {
    notifyTextInputWillEndEditing(textInput: textInput)
    return true
  }
  
  open func textInputDidEndEditing(_ textInput: TextInput) {
    notifyTextInputDidEndEditing(textInput: textInput)
  }
  
  // MARK: - Public
  open func setTextInput(_ textInput: TextInput) {
    self.textInput = textInput
    textInput.textInputDelegate = self
    setPrefixToTextInput()
  }
  
  open func unformattedText() -> String? {
    guard let textInput = textInput else { return nil }
    if let formatter = formatter, let text = textInput.text {
      return formatter.unformat(from: text)
    } else {
      return textInput.text
    }
  }
  
  open func setAndFormatText(_ text: String?) {
    guard let textInput = textInput else { return }
    if let formatter = formatter, let text = text {
      textInput.text = formatter.format(text: text)
    } else {
      textInput.text = text
    }
    notifyTextInputDidChangeText(textInput: textInput)
  }
}

// MARK: - Private
private extension TextInputController {
  /// Set and format current prefix
  func setPrefixToTextInput() {
    if let formattedPrefix = formattedPrefix {
      textInput?.text = formattedPrefix
    }
  }
  
  var formattedPrefix: String? {
    guard let formatter = formatter, let prefix = prefix else { return nil }
    return formatter.format(text: prefix)
  }
}

// MARK: - Subscribers notifications
private extension TextInputController {
  func notifyTextInputDidChangeText(textInput: TextInput) {
    observer.notifySubscribers { [weak self] subscriber in
      guard let weakSelf = self else { return }
      subscriber.textInputDidChangeText(textInput: textInput, controller: weakSelf)
    }
  }
  
  func notifyTextInputWasAskBeginEditing(textInput: TextInput) {
    observer.notifySubscribers { [weak self] subscriber in
      guard let weakSelf = self else { return }
      subscriber.textInputWasAskCanBeginEditing(textInput: textInput, controller: weakSelf)
    }
  }
  
  func notifyTextInputWillBeginEditing(textInput: TextInput) {
    observer.notifySubscribers { [weak self] subscriber in
      guard let weakSelf = self else { return }
      subscriber.textInputWillBeginEditing(textInput: textInput, controller: weakSelf)
    }
  }
  
  func notifyTextInputDidBeginEditing(textInput: TextInput) {
    observer.notifySubscribers { [weak self] subscriber in
      guard let weakSelf = self else { return }
      subscriber.textInputDidBeginEditing(textInput: textInput, controller: weakSelf)
    }
  }
  
  func notifyTextInputWillEndEditing(textInput: TextInput) {
    observer.notifySubscribers { [weak self] subscriber in
      guard let weakSelf = self else { return }
      subscriber.textInputWillEndEditing(textInput: textInput, controller: weakSelf)
    }
  }
  
  func notifyTextInputDidEndEditing(textInput: TextInput) {
    observer.notifySubscribers { [weak self] subscriber in
      guard let weakSelf = self else { return }
      subscriber.textInputDidEndEditing(textInput: textInput, controller: weakSelf)
    }
  }
}
