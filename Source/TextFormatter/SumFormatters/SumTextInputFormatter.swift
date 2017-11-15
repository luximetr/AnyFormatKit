//
//  SumTextInputFormatter.swift
//  AnyFormatKit
//
//  Created by BRANDERSTUDIO on 10.11.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import Foundation

public class SumTextInputFormatter: SumTextFormatter, TextInputFormatterProtocol {
    
    public var prefix: String?

    public var formattedPrefix: String?

    public var allowedSymbolsRegex: String?

    public override init(textPattern: String, specialSymbol: Character = "#") {
        super.init(textPattern: textPattern, specialSymbol: specialSymbol)
    }

    public func shouldChangeTextIn(textInput: TextInput, range: NSRange, replacementString text: String) -> Bool {
        
        return false
    }
    
    
  
  
}
