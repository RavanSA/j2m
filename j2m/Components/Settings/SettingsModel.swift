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
    var currentState: Bool?
    
    mutating func changeCurrentState(isActive: Bool) {
        currentState = isActive
    }
}

var settingsOptionForSwift: [Languages: [SettingsModel]] = [
    .swift: [
        SettingsModel(id: 1, description: "Explicit CodingKey values in Codable types ", currentState: false),
        SettingsModel(id: 2, description: "Use var instead of let for object properties", currentState: false),
        SettingsModel(id: 3, description: "Make all properties optional", currentState: false)
            ],
    .kotlin: [SettingsModel(id: 3, description: "Plain types only", currentState: false)]
]
