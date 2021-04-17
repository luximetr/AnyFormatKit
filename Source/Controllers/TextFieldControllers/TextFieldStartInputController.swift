//
//  TextFieldStartInputController.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 27.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class TextFieldStartInputController: NSObject, UITextFieldDelegate {
    
    open var formatter: (TextInputFormatter & CaretPositioner)?
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let formatter = formatter else { return true }
        let result = formatter.formatInput(
            currentText: textField.text ?? "",
            range: range,
            replacementString: string
        )
        textField.text = result.formattedText
        textField.setCursorLocation(result.caretBeginOffset)
        notifyEditingChanged(at: textField)
        return false
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let formatter = formatter else { return }
        let offset = formatter.getCaretOffset(for: textField.text ?? "")
        textField.setCursorLocation(offset)
    }
    
    private func notifyEditingChanged(at textField: UITextField) {
        textField.sendActions(for: .editingChanged)
        NotificationCenter.default.post(
            name: UITextField.textDidChangeNotification,
            object: textField
        )
    }
    
}
