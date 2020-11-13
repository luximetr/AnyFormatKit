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
  
  let phoneNumberInputController = TextFieldInputController()
  let cardNumberInputController = TextViewInputController()
  let sumInputController = TextFieldInputController()
  
  let phoneNumberField = UITextField(frame: LayoutConstants.phoneNumberFieldFrame)
  let cardNumberView = UITextView(frame: LayoutConstants.cardNumberFieldFrame)
  let sumInputField = UITextField(frame: LayoutConstants.sumTextInputFieldFrame)
  
  let phoneNumberFormatter = DefaultTextInputFormatter(textPattern: "### (###) ###-##-##")
  let cardNumberFormatter = DefaultTextInputFormatter(textPattern: "XXXX XXXX XXXX XXXX", patternSymbol: "X")
  let sumFormatter = SumTextInputFormatter(textPattern: "# ###,## $")
  let placeholderPhoneNumberFormatter = PlaceholderTextInputFormatter(textPattern: "### (###) ###-##-##")
  
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
    configurePhoneNumberField()
    configureCardNumberField()
    configureSumInputField()
    setupFirstResponder()
  }
  
  func configureSelfView() {
    view.backgroundColor = UIColor.black
  }
  
  func configureTitleLabels() {
    let phoneNumberTitleLabel = UILabel(frame: LayoutConstants.phoneNumberLabelFrame)
    phoneNumberTitleLabel.textColor = UIColor.white
    phoneNumberTitleLabel.font = UIFont.systemFont(ofSize: 15)
    phoneNumberTitleLabel.text = "Phone number: "
    
    let cardNumberTitleLabel = UILabel(frame: LayoutConstants.cardNumberLabelFrame)
    cardNumberTitleLabel.textColor = UIColor.white
    cardNumberTitleLabel.font = UIFont.systemFont(ofSize: 15)
    cardNumberTitleLabel.text = "Card number: "
    
    let sumTitleLabel = UILabel(frame: LayoutConstants.sumLabelFrame)
    sumTitleLabel.textColor = UIColor.white
    sumTitleLabel.font = UIFont.systemFont(ofSize: 15)
    sumTitleLabel.text = "Enter sum: "
    
    view.addSubview(phoneNumberTitleLabel)
    view.addSubview(cardNumberTitleLabel)
    view.addSubview(sumTitleLabel)
  }
  
  private func configurePhoneNumberField() {
    view.addSubview(phoneNumberField)
    phoneNumberField.backgroundColor = UIColor.black
    phoneNumberField.tintColor = ColorConstants.gray
    
    phoneNumberField.defaultTextAttributes = convertToNSAttributedStringKeyDictionary([
      NSAttributedString.Key.foregroundColor.rawValue: UIColor.white,
      NSAttributedString.Key.font.rawValue: getFont()])
//    phoneNumberInputController.formatter = phoneNumberFormatter
    phoneNumberInputController.formatter = placeholderPhoneNumberFormatter
    phoneNumberField.delegate = phoneNumberInputController
  }
  
  private func getFont() -> UIFont {
    if #available(iOS 13.0, *) {
      return UIFont.monospacedSystemFont(ofSize: 22, weight: .regular)
    } else if #available(iOS 9.0, *) {
      return UIFont.monospacedDigitSystemFont(ofSize: 22, weight: .regular)
    } else {
      return UIFont.systemFont(ofSize: 22)
    }
  }
  
  private func configureCardNumberField() {
    view.addSubview(cardNumberView)
    cardNumberView.backgroundColor = UIColor.black
    cardNumberView.tintColor = ColorConstants.gray
    cardNumberView.font = UIFont.systemFont(ofSize: 22)
    cardNumberView.textColor = .white
    cardNumberInputController.formatter = cardNumberFormatter
    cardNumberView.delegate = cardNumberInputController
  }
  
  private func configureSumInputField() {
    view.addSubview(sumInputField)
    sumInputField.backgroundColor = UIColor.black
    sumInputField.tintColor = ColorConstants.gray
    
    sumInputField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    sumInputField.defaultTextAttributes = convertToNSAttributedStringKeyDictionary([
      NSAttributedString.Key.foregroundColor.rawValue: UIColor.white,
      NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 22)])
    sumInputController.formatter = sumFormatter
    sumInputField.delegate = sumInputController
  }

  @objc
  func textDidChange(_ field: UITextField) {
    print("textDidChange \(field)")
  }
  
  func setupFirstResponder() {
    _ = phoneNumberField.becomeFirstResponder()
  }
}

// MARK: - Constants
private struct LayoutConstants {
  static let phoneNumberLabelFrame = CGRect(x: 20, y: 60, width: UIScreen.main.bounds.width - 40, height: 20)
  static let phoneNumberFieldFrame = CGRect(x: 20, y: 85, width: UIScreen.main.bounds.width - 40, height: 40)
  static let cardNumberLabelFrame = CGRect(x: 20, y: 160, width: UIScreen.main.bounds.width - 40, height: 20)
  static let cardNumberFieldFrame = CGRect(x: 20, y: 185, width: UIScreen.main.bounds.width - 40, height: 40)
  static let sumLabelFrame = CGRect(x: 20, y: 260, width: UIScreen.main.bounds.width - 40, height: 20)
  static let sumTextInputFieldFrame = CGRect(x: 20, y: 285, width: UIScreen.main.bounds.width - 40, height: 40)
}

private struct ColorConstants {
  static let yellow = UIColor(red: 255 / 255, green: 236 / 255, blue: 0 / 255, alpha: 1.0)
  static let gray = UIColor(red: 63 / 255, green: 63 / 255, blue: 63 / 255, alpha: 1.0)
}

// Helper function inserted by Swift 4.2 migrator.
private func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
