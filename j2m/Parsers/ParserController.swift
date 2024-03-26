//
//  ParserController.swift
//  testapp
//
//  Created by Revan Sadigli on 14.03.2024.
//

import Foundation

enum Languages: String {
    case swift = "Swift"
    case kotlin = "Kotlin"
}

class ParserController: NSObject {
    
    static let shared = ParserController()
    
    var selectedLanguage: Languages? {
        didSet {
            setLanguageForParsing()
        }
    }
    
    var jsonText: String? {
        didSet {
            setLanguageForParsing()
        }
    }
    
    var structName: String? {
        didSet {
            setLanguageForParsing()
        }
    }
    
    var swiftOptionForCodingKeys: Bool? {
        didSet {
            setLanguageForParsing()
        }
    }
    
    var swiftOptionForVarOrLet: Bool? {
        didSet {
            setLanguageForParsing()
        }
    }
    
    var swiftOptionForOptional: Bool? {
        didSet {
            setLanguageForParsing()
        }
    }
    
    override init() {
        super.init()

    }
    
    private func setLanguageForParsing() {
        switch selectedLanguage {
        case .swift:
            SwiftJsonParser(rawJsonText: jsonText ?? "", enumCodingKeysOption: swiftOptionForCodingKeys ?? false, varOrLet: swiftOptionForVarOrLet ?? false, isPropertiesOptional: swiftOptionForOptional ?? false).convertToSwiftModel(structName: structName)
            break
        case .kotlin:
            KotlinJsonParser(rawJsonText: jsonText ?? "").convertToKotlinDataClass()
        default:
            SwiftJsonParser(rawJsonText: jsonText ?? "", enumCodingKeysOption: swiftOptionForCodingKeys ?? false, varOrLet: swiftOptionForVarOrLet ?? false, isPropertiesOptional: swiftOptionForOptional ?? false).convertToSwiftModel(structName: structName)
        }
    }
    
}
