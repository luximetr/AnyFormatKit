//
//  TextInputFieldDelegateCall.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 13.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

/// Calling methods of textInputDelegates and textInputFieldDelegates with UITextFieldDelegate methods
extension TextInputField: UITextFieldDelegate {
  // MARK: - TextInputDelegate
   open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    guard
      let textInput = textField as? TextInputField,
      let textInputDelegate = textInputDelegate else { return true }
    let shouldBegin = textInputDelegate.textInputShouldBeginEditing(textInput)
    textInputDelegate.textInputWasAskBeginEditing(textInput)
    return shouldBegin
  }
  
  open func textFieldDidBeginEditing(_ textField: UITextField) {
    guard let textInput = textField as? TextInputField else { return }
    textInputDelegate?.textInputDidBeginEditing(textInput)
  }

  open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    guard
      let textInput = textField as? TextInputField,
      let textInputDelegate = textInputDelegate else { return true }
    return textInputDelegate.textInputShouldEndEditing(textInput)
  }
  
  open func textFieldDidEndEditing(_ textField: UITextField) {
    guard let textInput = textField as? TextInputField else { return }
    textInputDelegate?.textInputDidEndEditing(textInput)
  }
  
  open func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard
      let textInput = textField as? TextInputField,
      let textInputDelegate = textInputDelegate else { return true }
    return textInputDelegate.textInput(textInput, shouldChangeTextIn: range, replacementText: string)
  }
  
  // MARK: - TextInputFieldDelegate
  open func textFieldShouldClear(_ textField: UITextField) -> Bool {
    guard
      let textInput = textField as? TextInputField,
      let textInputFieldDelegate = textInputFieldDelegate else { return true }
    return textInputFieldDelegate.textInputShouldClear(textInput)
  }
  
  open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard
      let textInput = textField as? TextInputField,
      let textInputFieldDelegate = textInputFieldDelegate else { return true }
    return textInputFieldDelegate.textInputShouldReturn(textInput)
  }
  
  @available(iOS 10.0, *)
  open func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    guard let textInput = textField as? TextInputField else { return }
    textInputFieldDelegate?.textInputDidEndEditing(textInput, reason: reason)
  }
}
