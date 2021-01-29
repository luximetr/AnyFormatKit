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
    @State var text1 = ""
    @State var text2 = ""
    @State var text3 = ""
    
    var body: some View {
        VStack {
            Button("Button", action: {
                
            })
            TextField("TextField", text: $text1)
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
                formatter: DefaultTextInputFormatter(
                    textPattern: "XXXX XXXX XXXX XXXX",
                    patternSymbol: "X"
                )
            )
            .font(UIFont.monospacedSystemFont(ofSize: 20, weight: .bold))
            .foregroundColor(UIColor.brown)
            .accentColor(UIColor.purple)
            .borderStyle(.roundedRect)
            .onEditingBegan(perform: { (text) in
                print("onEditingBegan: " + (text ?? ""))
            })
            .onEditingEnd(perform: { (text) in
                print("onEditingEnd: " + (text ?? ""))
            })
            .onTextChange(perform: { text in
                print("onTextChange: " + (text ?? ""))
            })
            .onReturn(perform: {
                print("onReturn")
            })
            .onClear(perform: {
                print("onClear")
            })
            
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
