//
//  Optional.swift
//
//  Created by Mohamed Aglan®
//

import Foundation

extension Optional where Wrapped == Bool {
    mutating func toggleOptional() -> Bool {
        guard let value = self else {
            return true
        }
        return !value
    }
}
