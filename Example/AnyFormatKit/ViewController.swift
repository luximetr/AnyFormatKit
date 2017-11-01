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
  }
  
  func configureSelfView() {
    view.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
  }
  
  func configureTextField() {
    view.addSubview(textInputField)
    textInputField.defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.brown]
    textInputField.addAttributes([.foregroundColor : UIColor.black], range: NSRange(location: 0, length: 3))
    textInputField.addAttributes([.kern: 2.0], range: NSRange(location: 3, length: 7))
    textInputField.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    textInputField.textInputDelegates.add(delegate: self)
  }
  
  func configureTextView() {
    view.addSubview(textInputView)
    textInputView.typingAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.brown]
    textInputView.addAttributes([.foregroundColor : UIColor.black], range: NSRange(location: 0, length: 3))
    textInputView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
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
