//
//  ParserController.swift
//  testapp
//
//  Created by Revan Sadigli on 14.03.2024.
//

import Foundation

protocol Parser {
    @discardableResult
    func convertToModel(rootName: String?) -> String?
}

class ParserController {
    
    static let shared = ParserController()
    
    private var parser: Parser?
    
    var selectedLanguage: Languages? = .swift {
        didSet {
            updateParser()
        }
    }
    
    var jsonText: String? {
        didSet {
            updateParser()
        }
    }
    
    var structName: String? {
        didSet {
            updateParser()
        }
    }

    var swiftOptions: SwiftOptions = SwiftOptions(codingKeys: false, varOrLet: false, optionalProperties: false) {
        didSet {
            updateParser()
        }
    }
    
    private init() {}
    
    private func updateParser() {
        guard let selectedLanguage = selectedLanguage else {
            return
        }
        
        switch selectedLanguage {
        case .swift:
            parser = SwiftJsonParser(rawJsonText: jsonText ?? "",
                                                 enumCodingKeysOption: swiftOptions.codingKeys,
                                                 varOrLet: swiftOptions.varOrLet,
                                                 isPropertiesOptional: swiftOptions.optionalProperties)
        case .kotlin:
            parser = KotlinJsonParser(rawJsonText: jsonText ?? "")
        }
        
       _ = parser?.convertToModel(rootName: structName)
    }
    
}
