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
    guard let textInput = textView as? TextInputView else { return true }
    var shouldBegin = true
    textInputDelegates.invoke { delegate in
      shouldBegin = delegate.textInputShouldBeginEditing(textInput) && shouldBegin
    }
    return shouldBegin
  }
  
  open func textViewDidBeginEditing(_ textView: UITextView) {
    guard let textInput = textView as? TextInputView else { return }
    textInputDelegates.invoke { delegate in
      delegate.textInputDidBeginEditing(textInput)
    }
  }
  
  open func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    guard let textInput = textView as? TextInputView else { return true }
    var shouldEnd = true
    textInputDelegates.invoke { delegate in
      shouldEnd = delegate.textInputShouldEndEditing(textInput) && shouldEnd
    }
    return shouldEnd
  }
  
  open func textViewDidEndEditing(_ textView: UITextView) {
    guard let textInput = textView as? TextInputView else { return }
    textInputDelegates.invoke { delegate in
      delegate.textInputDidEndEditing(textInput)
    }
  }
  
  open func textView(_ textView: UITextView,
                shouldChangeTextIn range: NSRange,
                replacementText text: String) -> Bool {
    guard let textInput = textView as? TextInputView else { return true }
    var shouldChange = true
    textInputDelegates.invoke { delegate in
      shouldChange = delegate.textInput(
        textInput, shouldChangeTextIn: range, replacementText: text) && shouldChange
    }
    return shouldChange
  }
  
  // MARK: - TextInputViewDelegate
  open func textViewDidChange(_ textView: UITextView) {
    guard let textInput = textView as? TextInputView else { return }
    textInputViewDelegates.invoke { delegate in
      delegate.textInputDidChange(textInput)
    }
  }
  
  open func textViewDidChangeSelection(_ textView: UITextView) {
    guard let textInput = textView as? TextInputView else { return }
    textInputViewDelegates.invoke { delegate in
      delegate.textInputDidChangeSelection(textInput)
    }
  }
  
  @available(iOS 10.0, *)
  open func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    guard let textInput = textView as? TextInputView else { return true }
    var shouldInteract = true
    textInputViewDelegates.invoke { delegate in
      shouldInteract = delegate.textInput(
        textInput,
        shouldInteractWith: textAttachment,
        in: characterRange,
        interaction: interaction) && shouldInteract
    }
    return shouldInteract
  }
  
  @available(iOS 10.0, *)
  open func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    guard let textInput = textView as? TextInputView else { return true }
    var shouldInteract = true
    textInputViewDelegates.invoke { delegate in
      shouldInteract = delegate.textInput(
        textInput,
        shouldInteractWith: URL,
        in: characterRange,
        interaction: interaction) && shouldInteract
    }
    return shouldInteract
  }
}
