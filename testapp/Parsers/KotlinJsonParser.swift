//
//  KotlinJsonParser.swift
//  testapp
//
//  Created by Revan SADIGLI on 16.03.2024.
//

import Foundation

class KotlinJsonParser {
    
    var rawJsonText: String

    init(rawJsonText: String) {
        self.rawJsonText = rawJsonText
    }
    
    func convertToKotlinDataClass() {
        if let jsonData = rawJsonText.data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            let kotlinCode = generateDataClass(className: "Root", json: jsonObject)
            let userInfo: [String: Any] = ["model": kotlinCode]
            NotificationCenter.default.post(name: Notifications.didSelectLanguage, object: nil, userInfo: userInfo)        }
    }
    
    func generateDataClass(className: String, json: [String: Any]) -> String {
        var dataClassCode = "data class \(className) (\n"

        for (key, value) in json {
            let propertyType = getPropertyType(value)

            if let dictValue = value as? [String: Any] {
                dataClassCode += generateDataClass(className: key.capitalized, json: dictValue)
                dataClassCode += "    val \(key): \(key.capitalized)?\n"
            } else if let arrayValue = value as? [[String: Any]], !arrayValue.isEmpty {
                if let firstItem = arrayValue.first, let nestedObject = firstItem.keys.first {
                    dataClassCode += generateDataClass(className: nestedObject.capitalized, json: firstItem)
                    dataClassCode += "    val \(key): List<\(nestedObject.capitalized)>?\n"
                } else {
                    dataClassCode += "    val \(key): List<\(propertyType)>?\n"
                }
            } else {
                dataClassCode += "    val \(key): \(propertyType)?\n"
            }
        }

        dataClassCode += ")\n\n"
        return dataClassCode
    }
    
    func getPropertyType(_ value: Any) -> String {
        switch value {
        case is Int:
            return "Int"
        case is Double:
            return "Double"
        case is String:
            return "String"
        case is Bool:
            return "Bool"
        case is [String: Any]:
            return "Any"
        case let arrayValue as [[String: Any]] where !arrayValue.isEmpty:
            if let nestedObject = arrayValue.first?.keys.first {
                return "List<\(nestedObject.capitalized)>"
            } else {
                return "List<Any>"
            }
        default:
            return "Any"
        }
    }
}
