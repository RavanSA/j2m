//
//  KotlinJsonParser.swift
//  testapp
//
//  Created by Revan SADIGLI on 16.03.2024.
//

import Foundation

class KotlinJsonParser {
    
    var rawJsonText: String
    var dataClassArray: Set<String>
    var propertyType: String = "val"
    var optionalSign: String = "?"


    init(rawJsonText: String) {
        self.rawJsonText = rawJsonText
        self.dataClassArray = []
    }
    
    @discardableResult
    func convertToKotlinDataClass() -> String {
        if let jsonData = rawJsonText.data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            let kotlinCode = generateDataClass(className: "Root", json: jsonObject)
            let userInfo: [String: Any] = ["model": kotlinCode]
            NotificationCenter.default.post(name: Notifications.didSelectLanguage, object: nil, userInfo: userInfo)
            return kotlinCode
        }
        return ""
    }
    
    func generateDataClass(className: String, json: [String: Any]) -> String {
        var structsCode = ""
        
        for (key, value) in json {
            switch value {
            case let dictValue as [String: Any]:
                let structName = capitalizeFirstLetter(key)
                if !dataClassArray.contains(structName) {
                    structsCode += "data class \(structName)(\n\(generatePropertiesCode(from: dictValue)) )\n\n"
                    dataClassArray.insert(structName)
                    structsCode += generateDataClass(className: structName, json: dictValue)
                }
            case let arrayValue as [[String: Any]]:
                let structName = capitalizeFirstLetter(key)
                if !dataClassArray.contains(structName) {
                    _ = arrayValue[0].reduce("") { (result, arr) in
                        result + generatePropertiesCode(from: ["\(arr.key)": arr.value])
                    }
                    structsCode += generateDataClass(className: structName, json: arrayValue[0])
                    dataClassArray.insert(structName)
                }
            default:
                let structName = className.capitalized
                if !dataClassArray.contains(structName) {
                    structsCode += "data class \(structName)(\n\(generatePropertiesCode(from: json)))\n\n"
                    dataClassArray.insert(structName)
                }
            }
        }

        return structsCode
    }
    
    func generatePropertiesCode(from dictionary: [String: Any], _ onlyAddPropertyType: Bool = false) -> String {
        var propertiesCode = ""
        for (key, value) in dictionary {
            let propertyType: String
            
            if value is Int {
                propertyType = "Int"
            } else if value is Double {
                propertyType = "Double"
            } else if value is String {
                propertyType = "String"
            } else if value is Bool {
                propertyType = "Boolean"
            } else if value is [String: Any] {
                propertyType = "\(key)"
            } else if let arrayValue = value as? [Any], !arrayValue.isEmpty {
                if isPrimitiveType(arrayValue[0]) {
                    propertyType = "List<" + generatePropertiesCode(from: ["": arrayValue[0]], true) + ">"
                } else {
                    propertyType = "List<\(key)>".capitalized
                }
            } else {
                propertyType = "Any"
            }
            
            if !onlyAddPropertyType {
                if value is [String: Any] {
                    propertiesCode += "    \(self.propertyType) \(lowercaseFirstLetter(key)): \(capitalizeFirstLetter(propertyType))\(optionalSign)\n"
                } else {
                    propertiesCode += "    \(self.propertyType) \(lowercaseFirstLetter(key)): \(propertyType)\(optionalSign)\n"
                }
            } else {
                propertiesCode += " \(propertyType)"
            }

        }

        return propertiesCode
    }
    
    func capitalizeFirstLetter(_ text: String) -> String {
        let components = text.components(separatedBy: " ")
        let capitalizedComponents = components.map { $0.capitalized }
        return capitalizedComponents.joined()
    }
    
    func isPrimitiveType<T>(_ value: T) -> Bool {
        switch value {
        case is Int, is UInt, is Int8, is UInt8, is Int16, is UInt16, is Int32, is UInt32, is Int64, is UInt64, is Float, is Double, is Bool, is Character, is String, is NSNumber:
            return true
        default:
            return false
        }
    }
     
    func lowercaseFirstLetter(_ text: String) -> String {
        guard let firstChar = text.first else {
            return text
        }
        return String(firstChar).lowercased() + text.dropFirst()
    }
    
}
