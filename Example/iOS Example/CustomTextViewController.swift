//
//  CustomTextViewController.swift
//  iOS Example
//
//  Created by Aleksandr Orlov on 21.01.18.
//  Copyright © 2018 BRANDERSTUDIO. All rights reserved.
//

import Foundation
import AnyFormatKit

class CustomTextViewController: TextInputController {
  override func textInput(_ textInput: TextInput, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    return super.textInput(textInput, shouldChangeTextIn: range, replacementText: text)
  }
}
