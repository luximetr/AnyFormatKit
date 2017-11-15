#!/bin/bash
xcodebuild -workspace ../AnyFormatKit.xcworkspace -scheme "AnyFormatKit" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=11.1' test