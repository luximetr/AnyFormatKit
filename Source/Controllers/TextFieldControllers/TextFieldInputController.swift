//
//  TextFieldInputController.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

open class TextFieldInputController: NSObject, UITextFieldDelegate {
    
    open var formatter: TextInputFormatter?
    
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
    
    private func notifyEditingChanged(at textField: UITextField) {
        textField.sendActions(for: .editingChanged)
        NotificationCenter.default.post(
            name: UITextField.textDidChangeNotification,
            object: textField
        )
    }
    
}
