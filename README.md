# AnyFormatKit

[![CI Status](http://img.shields.io/travis/luximetr/AnyFormatKit.svg?style=flat)](https://travis-ci.org/luximetr/AnyFormatKit)
[![Version](https://img.shields.io/cocoapods/v/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)
[![License](https://img.shields.io/cocoapods/l/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)
[![Platform](https://img.shields.io/cocoapods/p/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)

Framework for text formatting written on Swift 4.0.

## Features

 |Features |
|------------------------------------------------------------|
Convert string in string with format and vice versa

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Swift 4.0 +
- Xcode 9.0.1 +

## Installation

AnyFormatKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AnyFormatKit'
```

## Usage

### Import

```swift
import AnyFormatKit
```

### Formatting with TextFormatter

```swift
let phoneFormatter = TextFormatter(textPattern: "### (###) ###-##-##")
phoneFormatter.formattedText(from: "+123456789012") // +12 (345) 678-90-12

let customFormatter = TextFormatter(textPattern: "###-###custom###-###")
customFormatter.formattedText(from: "111222333444") // 111-222custom333-444
```

You can also set own symbol in pattern

```swift
let cardFormatter = TextFormatter(textPattern: "XXXX XXXX XXXX XXXX", patternSymbol: "X")
cardFormatter.formattedText(from: "4444555566667777") // 4444 5555 6666 7777
```

For string with different length

```swift
let formatter = TextFormatter(textPattern: "## ###-##")
formatter.formattedText(from: "1234") // 12 34
formatter.formattedText(from: "123456789") // 12 345-67
```

Unformatting

```swift
let formatter = TextFormatter(textPattern: "## ###-##")
formatter.unformattedText(from: "99 888-77") // 9988877
```
### Formatting during typing

For formatting during typing is necessary to create TextInputController instance with formatter. You need to implement TextInput protocol in your own UITextField/UITextView/someone else or use ready solutions (TextInputField/TextInputView) by subclassing. It need to set controllers's textInput property.
```swift
let textInputController = TextInputController()

let textInput = TextInputField() // or TextInputView or any TextInput
textInputController.textInput = textInput // setting textInput

let formatter = TextInputFormatter(textPattern: "### (###) ###-##-##", prefix: "+12")
textInputController.formatter = formatter // setting formatter
```
Controller listen shouldChangeTextIn delegate method. But you can also add more than one delegate if needed. Methods of delegates, that should return Bool value gather with && operator. Such if one of delegates return false, that meens textInput will receive false. If you want to receive true to textInput, all delegates must return true.

You can set allowedSymbolsRegex to formatter to filter input symbols with regex. All symbols, that satisfy to RegEx will be able to typing in textInput.
This property only applies to inputed symbols from keybord, but not for prefix.

```swift
inputFieldFormatter.allowedSymbolsRegex = "[0-9]" // allowed only numbers
```

### Attributes for range

To set attributes for string at range use addAttributes(_, range) method for textInput.
```swift
textInput.addAttributes([.foregroundColor : UIColor.lightGray], range: NSRange(location: 0, length: 3))
```

## Author

luximetr, alexandr.orlov@brander.ua

## License

AnyFormatKit is available under the MIT license. See the LICENSE file for more info.
