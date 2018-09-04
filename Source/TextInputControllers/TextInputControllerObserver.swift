//
//  TextInputControllerObserver.swift
//  AnyFormatKit
//
//  Created by Aleksandr Orlov on 31.01.18.
//  Copyright © 2018 BRANDERSTUDIO. All rights reserved.
//

import Foundation

public protocol TextInputControllerObserver {
  func textInputDidChangeText(textInput: TextInput, controller: TextInputController)
  func textInputWillBeginEditing(textInput: TextInput, controller: TextInputController)
  func textInputDidBeginEditing(textInput: TextInput, controller: TextInputController)
  func textInputWillEndEditing(textInput: TextInput, controller: TextInputController)
  func textInputDidEndEditing(textInput: TextInput, controller: TextInputController)
}

public extension TextInputControllerObserver {
  func textInputDidChangeText(textInput: TextInput, controller: TextInputController) {}
  func textInputWillBeginEditing(textInput: TextInput, controller: TextInputController) {}
  func textInputDidBeginEditing(textInput: TextInput, controller: TextInputController) {}
  func textInputWillEndEditing(textInput: TextInput, controller: TextInputController) {}
  func textInputDidEndEditing(textInput: TextInput, controller: TextInputController) {}
}
