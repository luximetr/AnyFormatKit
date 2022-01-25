//
//  ExampleViewController.swift
//  AnyFormatKitSPMExample
//
//  Created by Oleksandr Orlov on 25.01.2022.
//

import UIKit
import AnyFormatKit

class ExampleViewController: UIViewController {
    
    // MARK: - View
    
    private let selfView = ExampleView()
    
    // MARK: - Controllers
    
    let phoneNumberInputController = TextFieldInputController()
    let cardNumberInputController = TextFieldStartInputController()
    let cardExpirationInputController = TextFieldStartInputController()
    let cardCVVInputController = TextFieldStartInputController()
    let moneyInputController = TextFieldStartInputController()
    
    // MARK: - Formatters
    
    let phoneNumberFormatter = DefaultTextInputFormatter(textPattern: "+5# (###) ###-##-##")
    let cardNumberFormatter = PlaceholderTextInputFormatter(textPattern: "#### #### #### ####")
    let cardExpirationFormatter = PlaceholderTextInputFormatter(textPattern: "__/__", patternSymbol: "_")
    let cardCVVFormatter = PlaceholderTextInputFormatter(textPattern: "***", patternSymbol: "*")
    let moneyFormatter = SumTextInputFormatter(textPattern: "# ###,## $")
    
    // MARK: - View life cycle

    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupPhoneNumberController()
        setupCardNumberController()
        setupCardExpirationController()
        setupCardCVVController()
        setupMoneyController()
    }
    
    // MARK: - Setup phoneNumber
    private func setupPhoneNumberController() {
        phoneNumberInputController.formatter = phoneNumberFormatter
        selfView.phoneNumberInputView.textField.delegate = phoneNumberInputController
    }
    
    // MARK: - Setup cardNumber
    private func setupCardNumberController() {
        cardNumberInputController.formatter = cardNumberFormatter
        selfView.cardNumberInputView.cardNumberTextField.delegate = cardNumberInputController
        selfView.cardNumberInputView.cardNumberTextField.text = cardNumberFormatter.format("")
    }
    
    private func setupCardExpirationController() {
        cardExpirationInputController.formatter = cardExpirationFormatter
        selfView.cardNumberInputView.expirationTextField.delegate = cardExpirationInputController
        selfView.cardNumberInputView.expirationTextField.text = cardExpirationFormatter.format("")
    }
    
    private func setupCardCVVController() {
        cardCVVInputController.formatter = cardCVVFormatter
        selfView.cardNumberInputView.cvvTextField.delegate = cardCVVInputController
        selfView.cardNumberInputView.cvvTextField.text = cardCVVFormatter.format("")
    }
    
    // MARK: - Setup money
    
    private func setupMoneyController() {
        moneyInputController.formatter = moneyFormatter
        selfView.moneyInputView.textField.delegate = moneyInputController
    }
}
