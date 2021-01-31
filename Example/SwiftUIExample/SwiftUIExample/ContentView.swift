//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Oleksandr Orlov on 28.01.2021.
//

import SwiftUI
import AnyFormatKit
import iPhoneNumberField

struct ContentView: View {
    
    @State public var isDarkMode: Bool = false
    @State var iPhoneNumberText = ""
    @State var unformattedCardNumberText = ""
    private let hardcodedCardNumber = "333111222"
    
    private let cardNumberFormatter = DefaultTextInputFormatter(textPattern: "XXXX XXXX XXXX XXXX", patternSymbol: "X")
    
    var body: some View {
        VStack {
            Button("Set unformatted card number", action: {
                unformattedCardNumberText = hardcodedCardNumber
            })
            .padding()
            Button("Print current text", action: {
//                print("iPhoneNumberText: " + iPhoneNumberText)
                print("unformattedCardNumberText: " + unformattedCardNumberText)
                isDarkMode.toggle()
            })
            .padding()
            iPhoneNumberField("iPhoneNumberField", text: $iPhoneNumberText)
                .font(UIFont.systemFont(ofSize: 30))
                .padding()
            AnyFormatTextField(
                unformattedText: $unformattedCardNumberText,
                placeholder: "AnyFormatTextField",
                formatter: cardNumberFormatter
            )
            .font(UIFont.monospacedSystemFont(ofSize: 20, weight: .bold))
            .foregroundColor(isDarkMode ? UIColor.brown : UIColor.blue)
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
