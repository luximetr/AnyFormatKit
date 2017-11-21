//
//  TextInputFormatterProtocol.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 18.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

/// Interface for formatter of TextInput, that allow change format of text during input
public protocol TextInputFormatterProtocol: TextFormatterProtocol {
  /// String, that always will be at beggining of textPattern text during typing
  var prefix: String? { get }
  
  /// Current prefix with current format
  var formattedPrefix: String? { get }
  
  // Regular expression, that discript allowed characters for input
  var allowedSymbolsRegex: String? { set get }
  
  // MARK: - open
  /**
   Method, that allow correct character by character input with specified format
   
   - Parameters:
     - textInput: Object, that conform to TextInput protocol and represent input field with correcting content
     - range: Range, that determine which symbols must to be replaced
     - replacementString: String, that will replace old content in determined range
   
   - Returns: Always return false (correct of textInput's content in method's body)
   */
  func shouldChangeTextIn(
    textInput: TextInput, range: NSRange, replacementString text: String) -> Bool
    

    /**
     Optionl method, that called when textInput starts editing
     
     - Parameters:
     - textInput: Object, that conform to TextInput protocol and represent input field with correcting content
    
     */
  func didBeginEditing(_ textInput: TextInput)
}

  //MARK: - Optional methods
extension TextInputFormatterProtocol {
    public func didBeginEditing(_ textInput: TextInput) {}
}
