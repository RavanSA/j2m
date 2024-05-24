//
//  LanguagesSettings.swift
//  j2m
//
//  Created by Revan Sadigli on 24.05.2024.
//

import Foundation

enum Languages: String {
    case swift = "Swift"
    case kotlin = "Kotlin"
}

struct SwiftOptions {
    var codingKeys: Bool
    var varOrLet: Bool
    var optionalProperties: Bool
}
