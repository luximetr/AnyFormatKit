//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Oleksandr Orlov on 28.01.2021.
//

import SwiftUI
import AnyFormatKit

struct ContentView: View {
    
    // MARK: - Data
    
    @State var phoneNumberText = ""
    @State var cardNumberText = ""
    @State var cardExpirationText = ""
    @State var cardCvvText = ""
    @State var moneyText = ""
    @State var money: NSNumber?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 1) {
                phoneNumberField
                cardNumberField
                HStack(spacing: 1) {
                    cardExpirationField
                    cardCvvField
                    Spacer()
                }
                moneyField
                printTextButton
                Spacer()
            }.background(Color.black)
        }
    }
    
    private var phoneNumberField: some View {
        VStack(alignment: .leading, spacing: 1, content: {
            Text("Phone number")
                .foregroundColor(.white)
                .padding(.leading)
            FormatTextField(
                unformattedText: $phoneNumberText,
                placeholder: "+1",
                textPattern: "+1 (###)-###-####"
            )
                .font(UIFont.monospacedSystemFont(ofSize: 18, weight: .regular))
                .placeholderColor(UIColor.white)
                .foregroundColor(UIColor.white)
                .frame(height: 44)
                .background(Color(.darkGray))
                .padding(.horizontal)
        })
    }
    
    private var cardNumberField: some View {
        VStack(alignment: .leading, spacing: 1, content: {
            Text("Card number")
                .foregroundColor(.white)
                .padding(.horizontal)
            FormatStartTextField(
                unformattedText: $cardNumberText,
                formatter: PlaceholderTextInputFormatter(textPattern: "#### #### #### ####")
            )
                .font(UIFont.monospacedSystemFont(ofSize: 18, weight: .regular))
                .foregroundColor(UIColor.white)
                .frame(height: 44)
                .background(Color(.darkGray))
                .padding(.horizontal)
        })
        .padding(.top, 15)
    }
    
    private var cardExpirationField: some View {
        FormatStartTextField(
            unformattedText: $cardExpirationText,
            formatter: PlaceholderTextInputFormatter(textPattern: "__/__", patternSymbol: "_")
        )
            .font(UIFont.monospacedSystemFont(ofSize: 18, weight: .regular))
            .foregroundColor(UIColor.white)
            .frame(width: 120, height: 44)
            .background(Color(.darkGray))
            .padding(.leading)
    }
    
    private var cardCvvField: some View {
        FormatStartTextField(
            unformattedText: $cardCvvText,
            formatter: PlaceholderTextInputFormatter(textPattern: "***", patternSymbol: "*")
        )
            .font(UIFont.monospacedSystemFont(ofSize: 18, weight: .regular))
            .foregroundColor(UIColor.white)
            .frame(width: 70, height: 44)
            .background(Color(.darkGray))
            .padding(.trailing)
    }
    
    private var moneyField: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text("Money")
                .foregroundColor(.white)
                .padding(.horizontal)
            FormatSumTextField(
                numberValue: $money, textPattern: "# ###.## $"
            )
                .font(UIFont.monospacedSystemFont(ofSize: 18, weight: .regular))
                .foregroundColor(UIColor.white)
                .frame(height: 44)
                .background(Color(.darkGray))
                .padding(.horizontal)
        }
        .padding(.top, 15)
    }
    
    private var printTextButton: some View {
        Button("Print values", action: {
            print("phone number: " + phoneNumberText)
            print("card number: " + cardNumberText)
            print("card exp: " + cardExpirationText)
            print("card cvv: " + cardCvvText)
            print("money: \(String(describing: money))")
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
