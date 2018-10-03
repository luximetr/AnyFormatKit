//
//  TextInputViewDelegateCall.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 13.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

/// Calling methods of textInputDelegates and textInputViewDelegates with UITextViewDelegate's methods
extension TextInputView: UITextViewDelegate {
  // MARK: - TextInputDelegate
  open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    guard
      let textInput = textView as? TextInputView,
      let textInputDelegate = textInputDelegate else { return true }
    let shouldBegin = textInputDelegate.textInputShouldBeginEditing(textInput)
    textInputDelegate.textInputWasAskBeginEditing(textInput)
    return shouldBegin
  }
  
  open func textViewDidBeginEditing(_ textView: UITextView) {
    guard let textInput = textView as? TextInputView else { return }
    textInputDelegate?.textInputDidBeginEditing(textInput)
  }
  
  open func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    guard
      let textInput = textView as? TextInputView,
      let textInputDelegate = textInputDelegate else { return true }
    return textInputDelegate.textInputShouldEndEditing(textInput)
  }
  
  open func textViewDidEndEditing(_ textView: UITextView) {
    guard let textInput = textView as? TextInputView else { return }
    textInputDelegate?.textInputDidEndEditing(textInput)
  }
  
  open func textView(_ textView: UITextView,
                shouldChangeTextIn range: NSRange,
                replacementText text: String) -> Bool {
    guard
      let textInput = textView as? TextInputView,
      let textInputDelegate = textInputDelegate else { return true }
    return textInputDelegate.textInput(textInput, shouldChangeTextIn: range, replacementText: text)
  }
  
  // MARK: - TextInputViewDelegate
  open func textViewDidChange(_ textView: UITextView) {
    guard let textInput = textView as? TextInputView else { return }
    textInputViewDelegate?.textInputDidChange(textInput)
  }
  
  open func textViewDidChangeSelection(_ textView: UITextView) {
    guard let textInput = textView as? TextInputView else { return }
    textInputViewDelegate?.textInputDidChangeSelection(textInput)
  }
  
  @available(iOS 10.0, *)
  open func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    guard
      let textInput = textView as? TextInputView,
      let textInputViewDelegate = textInputViewDelegate else { return true }
    return textInputViewDelegate.textInput(
      textInput,
      shouldInteractWith: textAttachment,
      in: characterRange,
      interaction: interaction)
    
  }
  
  @available(iOS 10.0, *)
  open func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    guard
      let textInput = textView as? TextInputView,
      let textInputViewDelegate = textInputViewDelegate else { return true }
    return textInputViewDelegate.textInput(
      textInput,
      shouldInteractWith: URL,
      in: characterRange,
      interaction: interaction)
  }
}
