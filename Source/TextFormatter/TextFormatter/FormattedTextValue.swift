//
//  FormattedTextValue.swift
//  AnyFormatKitTests
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import Foundation

public struct FormattedTextValue: Equatable {
  public let formattedText: String
  public let caretBeginOffset: Int
  
  public init(formattedText: String, caretBeginOffset: Int) {
    self.formattedText = formattedText
    self.caretBeginOffset = caretBeginOffset
  }
  
  public static var zero: FormattedTextValue {
    return FormattedTextValue(formattedText: "", caretBeginOffset: 0)
  }
}
