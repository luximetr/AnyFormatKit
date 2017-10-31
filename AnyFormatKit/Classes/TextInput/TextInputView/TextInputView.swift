//
//  InputTextView.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 09.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

public class TextInputView: AttributedTextInputView, TextInput {
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
  
  /// multicast delegate for TextInputField delegate methods
  private(set) public var textInputViewDelegates = MulticastDelegate<TextInputViewDelegate>()
  
  // MARK: - Unavailable fields
  @available(*, unavailable, message: "use content instead")
  public override var text: String! {
    set { super.text = newValue }
    get { return super.text }
  }
  
  @available(*, unavailable, message: "use attributedContent instead")
  public override var attributedText: NSAttributedString! {
    set { super.attributedText = newValue }
    get { return super.attributedText }
  }
  
  @available(*, unavailable, message: "use textInputDelegates and inputTextViewDelegates instead")
  public override var delegate: UITextViewDelegate? {
    get { return super.delegate }
    set { super.delegate = newValue }
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
