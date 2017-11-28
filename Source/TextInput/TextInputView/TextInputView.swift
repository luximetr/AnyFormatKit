//
//  InputTextView.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 09.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

open class TextInputView: AttributedTextInputView, TextInput {
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
  
  /// multicast delegate for TextInputField delegate methods
  private(set) open var textInputViewDelegates = MulticastDelegate<TextInputViewDelegate>()
  
  // MARK: - Unavailable fields
  @available(*, unavailable, message: "use content instead")
  open override var text: String! {
    set {}
    get { return nil }
  }
  
  @available(*, unavailable, message: "use attributedContent instead")
  open override var attributedText: NSAttributedString! {
    set {}
    get { return nil }
  }
  
  @available(*, unavailable, message: "use textInputDelegates and inputTextViewDelegates instead")
  open override var delegate: UITextViewDelegate? {
    set {}
    get { return nil }
  }
  
  // MARK: - Init
  public override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    initConfigure()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initConfigure()
  }
}

// MARK: - InitConfigure
private extension TextInputView {
  /// Init configure for text view
  func initConfigure() {
    setupDelegate()
  }
  
  /// Delegate is self for intercept delegate methods and transform it to TextInput delegate methods call
  func setupDelegate() {
    super.delegate = self
  }
}
