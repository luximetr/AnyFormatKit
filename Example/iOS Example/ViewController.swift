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
  
  let phoneNumberInputController = TextInputController()
  let cardNumberInputController = TextViewInputController()
  let sumInputController = TextInputController()
  
  let phoneNumberField = UITextField(frame: LayoutConstants.phoneNumberFieldFrame)
  let cardNumberView = UITextView(frame: LayoutConstants.cardNumberFieldFrame)
  let sumInputField = UITextField(frame: LayoutConstants.sumTextInputFieldFrame)
  
  let phoneNumberFormatter = DefaultTextInputFormatter(textPattern: "### (###) ###-##-##")
  let cardNumberFormatter = DefaultTextInputFormatter(textPattern: "XXXX XXXX XXXX XXXX", patternSymbol: "X")
  let sumFormatter = SumTextInputFormatter(textPattern: "#.###,# $")
  
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
    phoneNumberTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular )
    phoneNumberTitleLabel.text = "Phone number: "
    
    let cardNumberTitleLabel = UILabel(frame: LayoutConstants.cardNumberLabelFrame)
    cardNumberTitleLabel.textColor = UIColor.white
    cardNumberTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    cardNumberTitleLabel.text = "Card number: "
    
    let sumTitleLabel = UILabel(frame: LayoutConstants.sumLabelFrame)
    sumTitleLabel.textColor = UIColor.white
    sumTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
      NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 22, weight: .regular)])
    phoneNumberInputController.formatter = phoneNumberFormatter
    phoneNumberField.delegate = phoneNumberInputController
  }
  
  private func configureCardNumberField() {
    view.addSubview(cardNumberView)
    cardNumberView.backgroundColor = UIColor.black
    cardNumberView.tintColor = ColorConstants.gray
    cardNumberView.font = UIFont.systemFont(ofSize: 22, weight: .regular)
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
      NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 22, weight: .regular)])
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

class TextInputController: NSObject, UITextFieldDelegate {
  
  var formatter: TextInputFormatter?
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    print(textField.text ?? "")
    print(range)
    print(string)
    guard let formatter = formatter else { return true }
    let result = formatter.formatInput(currentText: textField.text ?? "", range: range, replacementString: string)
    textField.text = result.formattedText
    textField.setCursorLocation(result.caretBeginOffset)
    
    return false
  }
}


class TextViewInputController: NSObject, UITextViewDelegate {
  
  var formatter: TextInputFormatter?
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard let formatter = formatter else { return true }
    let result = formatter.formatInput(currentText: textView.text, range: range, replacementString: text)
    textView.text = result.formattedText
    textView.setCursorLocation(result.caretBeginOffset)
    
    return false
  }
}

private extension UITextField {
  
  func setCursorLocation(_ location: Int) {
    if let cursorLocation = position(from: beginningOfDocument, offset: location) {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.selectedTextRange = strongSelf.textRange(from: cursorLocation, to: cursorLocation)
      }
    }
  }
}

private extension UITextView {
  
  func setCursorLocation(_ location: Int) {
    if let cursorLocation = position(from: beginningOfDocument, offset: location) {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.selectedTextRange = strongSelf.textRange(from: cursorLocation, to: cursorLocation)
      }
    }
  }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
