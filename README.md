![AnyFormatKit: Simple text formatting in Swift](https://github.com/luximetr/AnyFormatKit/blob/develop/Assets/anyformatkit.png)


[![CI Status](http://img.shields.io/travis/luximetr/AnyFormatKit.svg?style=flat)](https://travis-ci.org/luximetr/AnyFormatKit)
[![Version](https://img.shields.io/cocoapods/v/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)
[![License](https://img.shields.io/cocoapods/l/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)
[![Platform](https://img.shields.io/cocoapods/p/AnyFormatKit.svg?style=flat)](http://cocoapods.org/pods/AnyFormatKit)
![Swift](https://img.shields.io/badge/%20in-swift%205.0-brightgreen.svg)

Text formatting framework written on Swift 5.0.

## Features

| |Features |
|-------------------|------------------------------------------------------------|
:performing_arts:| Convert string into formatted string and vice versa
:bicyclist:| Formatting text during typing
:hash:| Set format using '#' characters like '### ##-###'
:stuck_out_tongue:| Supporting emojis
:heavy_dollar_sign:| Formatting money amount
:parking:| Formatting with placeholders


## Example

To run the example project, clone the repo and run `pod install` from the Example directory first.

## Demo

![Phone number example](https://github.com/luximetr/AnyFormatKit/blob/develop/Assets/example_phone_number.gif)

![Currency example](https://github.com/luximetr/AnyFormatKit/blob/develop/Assets/example_sum.gif)

![Card number example](https://github.com/luximetr/AnyFormatKit/blob/develop/Assets/example_card_number.gif)

![Placeholder number number example](https://github.com/luximetr/AnyFormatKit/blob/develop/Assets/example_placeholder_phone_number.gif)

## Requirements

- iOS 8.0+
- Swift 4.0+
- Xcode 9.0+

## Migration Guides

- [AnyFormatKit 0.2.0 MigrationGuide](https://github.com/luximetr/AnyFormatKit/blob/master/Documentation/AnyFormatKit%200.2.0%20MigrationGuide.md)
- [AnyFormatKit 1.0.0 MigrationGuide](https://github.com/luximetr/AnyFormatKit/blob/master/Documentation/AnyFormatKit%201.0.0%20MigrationGuide.md)

## Installation

### CocoaPods

AnyFormatKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AnyFormatKit'
```

Then, run the following command:

```bash
$ pod install
```

### Swift Package Manager
AnyFormatKit is available with [Swift Package Manager](https://swift.org/package-manager/). 
Once you have your Swift package set up, than simply add AnyFormatKit to the `dependencies` value of your `Package.swift`

```swift
dependencies: [
    .package(url: "https://github.com/luximetr/AnyFormatKit.git", .upToNextMajor(from: "2.1.0"))
]
```

## Usage

### Import

```swift
import AnyFormatKit
```

### Formatting with TextFormatter

```swift
let phoneFormatter = DefaultTextFormatter(textPattern: "### (###) ###-##-##")
phoneFormatter.format("+123456789012") // +12 (345) 678-90-12

let customFormatter = DefaultTextFormatter(textPattern: "###-###custom###-###")
customFormatter.format("111222333444") // 111-222custom333-444
```

You can also set your own symbol in the pattern

```swift
let cardFormatter = DefaultTextFormatter(textPattern: "XXXX XXXX XXXX XXXX", patternSymbol: "X")
cardFormatter.format("4444555566667777") // 4444 5555 6666 7777
```

For string with different length

```swift
let formatter = DefaultTextFormatter(textPattern: "## ###-##")
formatter.format("1234") // 12 34
formatter.format("123456789") // 12 345-67
```

Unformatting

```swift
let formatter = DefaultTextFormatter(textPattern: "## ###-##")
formatter.unformat("99 888-77") // 9988877
```
### Formatting with PlaceholderTextFormatter

```swift
let phoneFormatter = PlaceholderTextFormatter(textPattern: "### (###) ###-##-##")
phoneFormatter.format("+123") // +12 (3##) ###-##-##
```

### Formatting with SumTextFormatter

```swift
let formatter = SumTextFormatter(textPattern: "#,###.##")
formatter.format("1234.13") // 1,234.13
```

### Formatting during typing

Using `DefaultTextInputFormatter` formatter

```swift
let formatter = DefaultTextInputFormatter(textPattern: "### (###) ###-##-##")

// inside of UITextFieldDelegate shouldChangeTextIn method
let result = formatter.formatInput(currentText: textView.text, range: range, replacementString: text)
textView.text = result.formattedText
textView.setCursorLocation(result.caretBeginOffset)
```

Using `SumTextInputFormatter` formatter

```swift
let formatter = SumTextInputFormatter(textPattern: "#,###.##$")

// inside of UITextFieldDelegate shouldChangeTextIn method
let result = formatter.formatInput(currentText: textView.text, range: range, replacementString: text)
textView.text = result.formattedText
textView.setCursorLocation(result.caretBeginOffset)
```

Using `PlaceholderTextInputFormatter` formatter

```swift
let formatter = PlaceholderTextInputFormatter(textPattern: "#### #### #### ####")

// inside of UITextFieldDelegate shouldChangeTextIn method
let result = formatter.formatInput(currentText: textView.text, range: range, replacementString: text)
textView.text = result.formattedText
textView.setCursorLocation(result.caretBeginOffset)
```

## Author

luximetr, luximetr.notification@gmail.com

### Say thank you

<a href="https://paypal.me/luximetr/"><img src="https://github.com/andreostrovsky/donate-with-paypal/blob/master/PNG/blue.png" height="40"></a>

## License

AnyFormatKit is available under the MIT license. See the LICENSE file for more info.
