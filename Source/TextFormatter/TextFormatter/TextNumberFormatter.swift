//
//  TextNumberFormatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 01.02.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

public protocol TextNumberFormatter {
    func format(_ number: NSNumber) -> String?
}
