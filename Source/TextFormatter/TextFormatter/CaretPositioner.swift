//
//  CaretPositioner.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 27.01.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import Foundation

public protocol CaretPositioner {
    func getCaretOffset(for text: String) -> Int
}
