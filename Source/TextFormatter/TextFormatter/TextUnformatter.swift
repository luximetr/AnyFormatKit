//
//  TextUnformatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

public protocol TextUnformatter {
    /**
     Method for convert string, that sutisfy current textPattern, into unformatted string
     
     - Parameters:
       - formatted: String to convert
     
     - Returns: String converted into unformatted
     */
    func unformat(_ formattedText: String?) -> String?
}
