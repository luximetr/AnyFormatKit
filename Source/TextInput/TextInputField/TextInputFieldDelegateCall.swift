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
   public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    guard let textInput = textField as? TextInputField else { return true }
    var shouldBegin = true
    textInputDelegates.invoke { delegate in
      shouldBegin = delegate.textInputShouldBeginEditing(textInput) && shouldBegin
    }
    return shouldBegin
  }
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    guard let textInput = textField as? TextInputField else { return }
    textInputDelegates.invoke { delegate in
      delegate.textInputDidBeginEditing(textInput)
    }
  }

  public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    guard let textInput = textField as? TextInputField else { return true }
    var shouldEnd = true
    textInputDelegates.invoke { delegate in
      shouldEnd = delegate.textInputShouldEndEditing(textInput) && shouldEnd
    }
    return shouldEnd
  }
  
  public func textFieldDidEndEditing(_ textField: UITextField) {
    guard let textInput = textField as? TextInputField else { return }
    textInputDelegates.invoke { delegate in
      delegate.textInputDidEndEditing(textInput)
    }
  }
  
  public func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard let textInput = textField as? TextInputField else { return true }
    var shouldChange = true
    textInputDelegates.invoke { delegate in
      shouldChange = delegate.textInput(
        textInput, shouldChangeTextIn: range, replacementText: string) && shouldChange
    }
    return shouldChange
  }
  
  // MARK: - TextInputFieldDelegate
  public func textFieldShouldClear(_ textField: UITextField) -> Bool {
    guard let textInput = textField as? TextInputField else { return true }
    var shouldClear = true
    textInputFieldDelegates.invoke { delegate in
      shouldClear = delegate.textInputShouldClear(textInput) && shouldClear
    }
    return shouldClear
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let textInput = textField as? TextInputField else { return true }
    var shouldReturn = true
    textInputFieldDelegates.invoke { delegate in
      shouldReturn = delegate.textInputShouldReturn(textInput) && shouldReturn
    }
    return shouldReturn
  }
  
  @available(iOS 10.0, *)
  public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
    guard let textInput = textField as? TextInputField else { return }
    textInputFieldDelegates.invoke { delegate in
      delegate.textInputDidEndEditing(textInput, reason: reason)
    }
  }
}
