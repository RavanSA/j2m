//
//  SwiftJsonParser.swift
//  testapp
//
//  Created by Revan Sadigli on 14.03.2024.
//

import Foundation

// MARK: BUG
// 1. if first element json is dictionary or object
// 2. nested array element

class SwiftJsonParser: NSObject {

    var rawJsonText: String

    init(rawJsonText: String) {
        self.rawJsonText = rawJsonText
    }
    
    func convertToSwiftModel() {
        if let jsonData = rawJsonText.data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            
            let swiftCode = /*generateTopLevelStruct(parentName: "Root", json: jsonObject) +*/ generateSwiftStructs(from: jsonObject)
            let userInfo: [String: Any] = ["model": swiftCode]
            NotificationCenter.default.post(name: Notifications.didSelectLanguage, object: nil, userInfo: userInfo)
        }
    }
    
    func generateSwiftStructs(from json: [String: Any], parentName: String = "Root") -> String {
        var structsCode = ""
        var structsArray: [String] = []

        for (key, value) in json {
            // MARK: BUG - 1 - if the firselement of the dict is object generate top struct

            if let dictValue = value as? [String: Any] {
                let structName = capitalizeFirstLetter(key)
                guard !structsArray.contains(structName) else { continue }
                let propertiesCode = generatePropertiesCode(from: dictValue)
//                structsCode += "struct \(structName): Codable {\n\(propertiesCode)\n}\n\n"
                structsCode += generateSwiftStructs(from: dictValue, parentName: structName)
                structsArray.append(structName)
            } else if let arrayValue = value as? [[String: Any]] {
                // MARK: BUG - 2 - nested arrays element need to be function recursive
                let structName = capitalizeFirstLetter(key)
                guard !structsArray.contains(structName) else { continue }
                var propertiesCode = ""
                arrayValue[0].forEach { arr in
                    propertiesCode += generatePropertiesCode(from: ["\(arr.key)": arr.value])
                }
                structsCode += "struct \(structName): Codable {\n\(propertiesCode)\n}\n\n"
                structsArray.append(structName)
            } else {
                let structName = parentName.capitalized
                guard !structsArray.contains(structName) else { continue }

                structsCode += "struct \(structName): Codable {\n\(generatePropertiesCode(from: json))\n}\n\n"
                structsArray.append(structName)
            }
        }

        return structsCode
    }

    func capitalizeFirstLetter(_ text: String) -> String {
        let components = text.components(separatedBy: " ")
        let capitalizedComponents = components.map { $0.capitalized }
        return capitalizedComponents.joined()
    }
    
    
    func generateTopLevelStruct(parentName: String, json: [String: Any]) -> String {
        var structsCode = ""
        let topLevelStructName = capitalizeFirstLetter(parentName)
        structsCode += "struct \(topLevelStructName): Codable {\n"
        for (key, value) in json {
            let propertyName = capitalizeFirstLetter(key)
            if let _ = value as? [String: Any] {
                structsCode += "    let \(key): \(propertyName)?\n"
            } else if let _ = value as? [[String: Any]] {
                structsCode += "    let \(key): [\(propertyName)]?\n"
            } else {
                structsCode += "    let \(key): \(type(of: value))?\n"
            }
        }
        structsCode += "}\n\n"
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
                propertyType = "Bool"
            } else if value is [String: Any] {
                propertyType = "\(key)"
            } else if let arrayValue = value as? [Any], !arrayValue.isEmpty  {
                if isPrimitiveType(arrayValue[0]) {
                    print("arrayvalue2 \(key)", arrayValue[0])
                    propertyType = "[" + generatePropertiesCode(from: ["": arrayValue[0]], true) + "]"
                } else {
                    propertyType = "[\(key)]".capitalized
                }
            } else {
                propertyType = "Any"
            }
            
            if !onlyAddPropertyType {
                if value is [String: Any] {
                    propertiesCode += "    let \(lowercaseFirstLetter(key)): \(capitalizeFirstLetter(propertyType))?\n"
                } else {
                    propertiesCode += "    let \(lowercaseFirstLetter(key)): \(propertyType)?\n"
                }
            } else {
                propertiesCode += " \(propertyType)"
            }

        }

        return propertiesCode
    }
    
    func lowercaseFirstLetter(_ text: String) -> String {
        guard let firstChar = text.first else {
            return text
        }
        return String(firstChar).lowercased() + text.dropFirst()
    }
    
    func isPrimitiveType<T>(_ value: T) -> Bool {
        switch value {
        case is Int, is UInt, is Int8, is UInt8, is Int16, is UInt16, is Int32, is UInt32, is Int64, is UInt64, is Float, is Double, is Bool, is Character, is String, is NSNumber:
            return true
        default:
            return false
        }
    }
    
}
