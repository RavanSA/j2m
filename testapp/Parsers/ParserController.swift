//
//  ParserController.swift
//  testapp
//
//  Created by Revan Sadigli on 14.03.2024.
//

import Foundation

enum Languages: String {
    case swift = "Swift"
    case kotlin = "Kotlin (Beta)"
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
    
    override init() {
        super.init()

    }
    
    private func setLanguageForParsing() {
        switch selectedLanguage {
        case .swift:
            SwiftJsonParser(rawJsonText: jsonText ?? "").convertToSwiftModel()
            break
        case .kotlin:
            KotlinJsonParser(rawJsonText: jsonText ?? "").convertToKotlinDataClass()
        default:
            SwiftJsonParser(rawJsonText: jsonText ?? "").convertToSwiftModel()
        }
    }
    
}
