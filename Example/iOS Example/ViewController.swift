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
  //let textInputViewController = TextInputController()
  let sumInputController = TextInputController()
    
  let textInputField = TextInputField(frame: LayoutConstants.textInputFieldFrame)
  //let textInputView = TextInputView(frame: LayoutConstants.textInputViewFrame)
  
  let phoneNumberFormatter = TextInputFormatter(textPattern: "### (###) ###-##-##", prefix: "+12")
  //let cardNumberFormatter = TextInputFormatter(textPattern: "XXXX XXXX XXXX XXXX", patternSymbol: "X")
    let sumFormatter = SumTextInputFormatter(textPattern: "Your input: #,###.# $$", specialSymbol: "#")
  
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
    configureTitleLabels()
    configureTextField()
    //configureTextView()
    configureFormatters()
    configureTextFieldController()
    //configureTextViewController()
    setupFirstResponder()
  }
  
  func configureSelfView() {
    view.backgroundColor = UIColor.black
  }
  
  func configureTitleLabels() {
    let phoneNumberTitleLabel = UILabel(frame: LayoutConstants.phoneNumberLabelFrame)
    phoneNumberTitleLabel.textColor = UIColor.white
    phoneNumberTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular )
    phoneNumberTitleLabel.text = "Phone number: "
    
    let cardNumberTitleLabel = UILabel(frame: LayoutConstants.cardNumberLabelFrame)
    cardNumberTitleLabel.textColor = UIColor.white
    cardNumberTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    cardNumberTitleLabel.text = "Card number: "
    
    view.addSubview(phoneNumberTitleLabel)
    view.addSubview(cardNumberTitleLabel)
  }
  
  func configureTextField() {
    view.addSubview(textInputField)
    textInputField.backgroundColor = UIColor.black
    textInputField.tintColor = ColorConstants.gray
    
    textInputField.textInputDelegates.add(delegate: self)
    textInputField.defaultTextAttributes = [
      NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
      NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 22, weight: .regular)]
    //textInputField.addAttributes([.foregroundColor : ColorConstants.yellow], range: NSRange(location: 0, length: 3))
    textInputField.content = sumFormatter.formattedText(from: "123456")
  }
  
//  func configureTextView() {
//    view.addSubview(textInputView)
//    textInputView.backgroundColor = UIColor.black
//    textInputView.tintColor = ColorConstants.gray
//
//    textInputView.typingAttributes = [
//      NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 22, weight: .regular),
//      NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
//    textInputView.addAttributes([.foregroundColor : ColorConstants.yellow], range: NSRange(location: 0, length: 4))
//
//    textInputView.content = cardNumberFormatter.formattedText(from: "4111012345672390")
//
//  }
  
  func configureFormatters() {
    //sumFormatter.allowedSymbolsRegex = "^[0-9]{1,2}([,.][0-9]{1,2})?$"
    //phoneNumberFormatter.allowedSymbolsRegex = "[0-9]"
    //cardNumberFormatter.allowedSymbolsRegex = "[0-9]"
  }
  
  func configureTextFieldController() {
    sumInputController.textInput = textInputField
    sumInputController.formatter = sumFormatter
//    textInputFieldController.textInput = textInputField
//    textInputFieldController.formatter = phoneNumberFormatter
  }
  
  func configureTextViewController() {
    //textInputViewController.textInput = textInputView
    //textInputViewController.formatter = cardNumberFormatter
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
  static let textInputFieldFrame = CGRect(x: 20, y: 65, width: UIScreen.main.bounds.width - 40, height: 40)
  static let textInputViewFrame = CGRect(x: 16, y: 165, width: UIScreen.main.bounds.width - 40, height: 40)
  static let phoneNumberLabelFrame = CGRect(x: 20, y: 40, width: UIScreen.main.bounds.width - 40, height: 20)
  static let cardNumberLabelFrame = CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 40, height: 20)
}

private struct ColorConstants {
  static let yellow = UIColor(red: 255 / 255, green: 236 / 255, blue: 0 / 255, alpha: 1.0)
  static let gray = UIColor(red: 63 / 255, green: 63 / 255, blue: 63 / 255, alpha: 1.0)
}
