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
    @State var text = ""
    @State var text2 = ""
    @State var text3 = "aa"
    
    var body: some View {
        VStack {
            iPhoneNumberField("iPhoneNumberField", text: $text)
                .font(UIFont.systemFont(ofSize: 30))
                .padding()
            AnyFormatTextField(
                text: $text2,
                placeholder: "with textPattern",
                textPattern: "### (###) ###-##-##"
            ).font(UIFont.systemFont(ofSize: 16))
             .placeholderColor(Color.green)
             .padding()
            AnyFormatTextField(
                text: $text3,
                placeholder: "with formatter",
                formatter: PlaceholderTextInputFormatter(
                    textPattern: "XXXX XXXX XXXX XXXX",
                    patternSymbol: "X"
                )
            ).font(UIFont.monospacedSystemFont(ofSize: 20, weight: .bold))
             .accentColor(UIColor.purple)
             .borderStyle(.roundedRect)
             .textAlignment(.center)
             .padding()
             .environment(\.layoutDirection, .rightToLeft)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
