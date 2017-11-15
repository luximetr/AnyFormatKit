//
//  InputTextField.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 09.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

public class  TextInputField: AttributedTextInputField, TextInput {
  // MARK: - TextInput
  public var content: String? {
    set { super.text = newValue }
    get { return super.text }
  }
  
  public var attributedContent: NSAttributedString? {
    set { super.attributedText = newValue }
    get { return super.attributedText }
  }
  
  private(set) public var textInputDelegates = MulticastDelegate<TextInputDelegate>()
  
  /// Multicast delegate for TextInputField delegate methods
  private(set) public var textInputFieldDelegates = MulticastDelegate<TextInputFieldDelegate>()
  
  // MARK: - Unavailable fields
  @available(*, unavailable, message: "use content instead")
  public override var text: String? {
    set { super.text = newValue }
    get { return super.text }
  }
  
  @available(*, unavailable, message: "use attributedContent instead")
  public override var attributedText: NSAttributedString? {
    set { super.attributedText = newValue }
    get { return super.attributedText }
  }
  
  @available(*, unavailable, message: "use textInputDelegates and textInputFieldDelegates instead")
  public override var delegate: UITextFieldDelegate? {
    set { super.delegate = newValue }
    get { return super.delegate }
  }

  // MARK: - Init
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initConfigure()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initConfigure()
  }
}

// MARK: - InitConfigure
private extension TextInputField {
  /// Init configure of text field
  func initConfigure() {
    setupDelegate()
  }
  
  /// Delegate is self for intercept delegate methods and transform it to TextInput delegate methods call
  func setupDelegate() {
    super.delegate = self
  }
}
