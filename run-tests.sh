#!/bin/bash
xcodebuild -workspace AnyFormatKit.xcworkspace -scheme "AnyFormatKit" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.3' test