//
//  TextViewInputController.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class TextViewInputController: NSObject, UITextViewDelegate {
    
    open var formatter: TextInputFormatter?
    
    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let formatter = formatter else { return true }
        let result = formatter.formatInput(
            currentText: textView.text,
            range: range,
            replacementString: text
        )
        textView.text = result.formattedText
        textView.setCursorLocation(result.caretBeginOffset)
        return false
    }
    
}
