//
//  ProjectTableViewCell.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa
import macOSThemeKit

class LanguageTableCellView: NSTableCellView {

    @IBOutlet weak var backgroundBox: NSBox!
    @IBOutlet weak var languageText: NSTextField!

    var isSelected = false
    
    func setup(item: LanguagesModel) {
        self.languageText.stringValue = item.language.rawValue
        self.languageText.textColor = ThemeColor.textColor
    }
    
    func applySelectedCell() {
        self.backgroundBox.isHidden = !self.isSelected
    }
    
}
