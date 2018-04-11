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
  open weak var textInputDelegate: TextInputDelegate?
  open weak var textInputViewDelegate: TextInputViewDelegate?
  
  // MARK: - Unavailable fields
  open override var text: String? {
    set { super.text = newValue }
    get { return super.text }
  }
  
  open override var attributedText: NSAttributedString? {
    set { super.attributedText = newValue }
    get { return super.attributedText }
  }
  
  @available(*, unavailable, message: "use textInputDelegate and inputTextViewDelegate instead")
  open override var delegate: UITextViewDelegate? {
    set { super.delegate = newValue }
    get { return super.delegate }
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
