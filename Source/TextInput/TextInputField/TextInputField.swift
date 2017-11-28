//
//  InputTextField.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 09.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

open class TextInputField: AttributedTextInputField, TextInput {
  // MARK: - TextInput
  open var content: String? {
    set { super.text = newValue }
    get { return super.text }
  }
  
  open var attributedContent: NSAttributedString? {
    set { super.attributedText = newValue }
    get { return super.attributedText }
  }
  
  private(set) open var textInputDelegates = MulticastDelegate<TextInputDelegate>()
  
  /// Multicast delegate for TextInputField delegate methods
  private(set) open var textInputFieldDelegates = MulticastDelegate<TextInputFieldDelegate>()
  
  // MARK: - Unavailable fields
  @available(*, unavailable, message: "use content instead")
  open override var text: String? {
    set {}
    get { return nil }
  }
  
  @available(*, unavailable, message: "use attributedContent instead")
  open override var attributedText: NSAttributedString? {
    set {}
    get { return nil }
  }
  
  @available(*, unavailable, message: "use textInputDelegates and textInputFieldDelegates instead")
  open override var delegate: UITextFieldDelegate? {
    set {}
    get { return nil }
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
