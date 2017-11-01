//
//  AttributedTextInputField.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 25.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

/// Subclass of UITextField, that work always with attributedText even when you use text
public class AttributedTextInputField: UITextField {
  // MARK: - Fields
  /// Overriden text, that set text with attributes to attributedText property
  override public var text: String? {
    set { super.attributedText = attributedStringConstructor.attributedStringWithAttributes(
      newValue: newValue, commonAttributes: defaultTextAttributes) }
    get { return super.attributedText?.string }
  }
  
  /// Common attributes for all string during typing
  private var commonAttributes = [String : Any]()
  override public var defaultTextAttributes: [String : Any] {
    set { commonAttributes = newValue }
    get { return commonAttributes }
  }
  
  /// String constructor, that contain dictionaries of attributes, that will apply for input text
  private let attributedStringConstructor = AttributedStringConstructor()

  // MARK: - Public
  
  /**
   Add attributes for range
   
   - Parameters:
     - newAttributes: Dictionary of attributes with values
     - range: Range in string, that will format will attributes
   */
  public func addAttributes(_ newAttributes: [NSAttributedStringKey: Any], range: NSRange) {
    attributedStringConstructor.addAttributes(newAttributes, range: range)
  }
  
  /**
   Remove attribute for range
   
   - Parameters:
     - attribute: Attribute, that will remove
     - range: Range, that was set with attribute, range is a key for remove
   */
  public func removeAttribute(_ attribute: NSAttributedStringKey, range: NSRange) {
    attributedStringConstructor.removeAttribute(attribute, range: range)
  }
  
  /// Remove all attributes
  public func removeAllAttributes() {
    attributedStringConstructor.removeAllAttributes()
  }
}
