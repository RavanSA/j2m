//
//  SettingsModel.swift
//  testapp
//
//  Created by Revan SADIGLI on 20.03.2024.
//

import Foundation

struct SettingsModel {
    let id: Int
    let description: String
    let currentState: Bool?
}

var settingsOptionForSwift: [SettingsModel] = [
    SettingsModel(id: 1, description: "Explicit CodingKey values in Codable types ", currentState: false),
    SettingsModel(id: 2, description: "Plain types only", currentState: false)
    
]
