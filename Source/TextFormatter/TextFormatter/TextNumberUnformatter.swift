//
//  TextNumberUnformatter.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 18.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

public protocol TextNumberUnformatter {
    func unformatNumber(_ formattedText: String?) -> NSNumber?
}
