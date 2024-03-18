//
//  LanguagesModel.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Foundation

struct LanguagesModel {
    var language: Languages
    var id: Int
}

var languages = [
    LanguagesModel(language: .swift, id: 1),
    LanguagesModel(language: .kotlin, id: 2)
]
