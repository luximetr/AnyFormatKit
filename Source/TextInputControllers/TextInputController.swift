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
      textInput?.textInputDelegate = self
      setPrefixToTextInput()
    }
  }
  /// Formatter, that apply format for text during editing
  open var formatter: TextInputFormatterProtocol? {
    didSet {
      setPrefixToTextInput()
    }
  }
  
  public let observer = Observer<TextInputControllerObserver>()
  
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
    if let formatter = formatter {
      let shouldChange = formatter.shouldChangeTextIn(
        textInput: textInput, range: range, replacementString: text)
        notifyTextInputDidChangeText(textInput: textInput)
      return shouldChange
    }
    notifyTextInputDidChangeText(textInput: textInput)
    return true
  }
  
  open func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool {
    notifyTextInputWillBeginEditing(textInput: textInput)
    return true
  }
    
  open func textInputDidBeginEditing(_ textInput: TextInput) {
    if let formatter = formatter {
      formatter.didBeginEditing(textInput)
    }
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
  open func unformattedText() -> String? {
    guard let textInput = textInput else { return nil }
    if let formatter = formatter {
      return formatter.unformattedText(from: textInput.text)
    } else {
      return textInput.text
    }
  }
  
  open func setAndFormatText(_ text: String?) {
    guard let textInput = textInput else { return }
    if let formatter = formatter {
      textInput.text = formatter.formattedText(from: text)
    } else {
      textInput.text = text
    }
  }
}

// MARK: - Private
private extension TextInputController {
  /// Set and format current prefix
  func setPrefixToTextInput() {
    if let formattedPrefix = formatter?.formattedPrefix {
      textInput?.text = formattedPrefix
    }
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
