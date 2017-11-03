//
//  ViewController.swift
//  AnyFormatKit
//
//  Created by luximetr on 10/31/2017.
//  Copyright (c) 2017 luximetr. All rights reserved.
//

import UIKit
import AnyFormatKit

class ViewController: UIViewController {
  // MARK: - Fields
  let textInputFieldController = TextInputController()
  let textInputViewController = TextInputController()
  
  let textInputField = TextInputField(frame: LayoutConstants.textInputFieldFrame)
  let textInputView = TextInputView(frame: LayoutConstants.textInputViewFrame)
  
  let inputFieldFormatter = TextInputFormatter(textPattern: "### (###) ###-##-##", prefix: "+12")
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initConfigure()
  }
}

// MARK: - Private
private extension ViewController {
  func initConfigure() {
    configureSelfView()
    configureTextField()
    configureTextView()
    configureFormatter()
    configureTextFieldController()
    configureTextViewController()
    setupFirstResponder()
  }
  
  func configureSelfView() {
    view.backgroundColor = UIColor.black
  }
  
  func configureTextField() {
    view.addSubview(textInputField)
    textInputField.backgroundColor = UIColor.black
    textInputField.tintColor = UIColor.black
    textInputField.font = UIFont.systemFont(ofSize: 22, weight: .regular)
    textInputField.textColor = UIColor.white
    
    textInputField.textInputDelegates.add(delegate: self)
    textInputField.addAttributes([.foregroundColor : ColorConstants.yellow], range: NSRange(location: 0, length: 3))
  }
  
  func configureTextView() {
    view.addSubview(textInputView)
    textInputView.backgroundColor = UIColor.black
    textInputView.tintColor = ColorConstants.gray
    
    textInputView.typingAttributes = [
      NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 22, weight: .regular),
      NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
    textInputView.addAttributes([.foregroundColor : ColorConstants.yellow], range: NSRange(location: 0, length: 3))
  }
  
  func configureFormatter() {
    inputFieldFormatter.allowedSymbolsRegex = "[0-9]"
  }
  
  func configureTextFieldController() {
    textInputFieldController.textInput = textInputField
    textInputFieldController.formatter = inputFieldFormatter
  }
  
  func configureTextViewController() {
    textInputViewController.textInput = textInputView
    textInputViewController.formatter = inputFieldFormatter
  }
  
  func setupFirstResponder() {
    _ = textInputField.becomeFirstResponder()
  }
}

// MARK: - TextInputDelegate
extension ViewController: TextInputDelegate {
  func textInputDidBeginEditing(_ textInput: TextInput) {
    print("textInputDidBeginEditing")
  }
  
  func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool {
    return true
  }
}

// MARK: - Constants
private struct LayoutConstants {
  static let textInputFieldFrame = CGRect(x: 20, y: 40, width: UIScreen.main.bounds.width - 40, height: 40)
  static let textInputViewFrame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 40)
}

private struct ColorConstants {
  static let yellow = UIColor(red: 255 / 255, green: 236 / 255, blue: 0 / 255, alpha: 1.0)
  static let gray = UIColor(red: 63 / 255, green: 63 / 255, blue: 63 / 255, alpha: 1.0)
}
