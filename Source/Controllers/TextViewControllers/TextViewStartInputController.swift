//
//  TextViewStartInputController.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 27.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

class TextViewStartInputController: NSObject, UITextViewDelegate {
    
    open var formatter: (TextInputFormatter & CaretPositioner)?
    
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
    
    open func textViewDidBeginEditing(_ textView: UITextView) {
        guard let formatter = formatter else { return }
        let offset = formatter.getCaretOffset(for: textView.text)
        textView.setCursorLocation(offset)
    }
}
