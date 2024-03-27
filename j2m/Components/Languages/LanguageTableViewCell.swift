//
//  ProjectTableViewCell.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa

class LanguageTableCellView: NSTableCellView {

    @IBOutlet weak var backgroundBox: NSBox!
    @IBOutlet weak var languageText: NSTextField!

    var isSelected = false
    
    func setup(item: LanguagesModel) {
        self.languageText.stringValue = item.language.rawValue
        self.languageText.textColor = NSColor(hex: 0xffffff)
    }
    
    func applySelectedCell() {
        self.backgroundBox.isHidden = !self.isSelected
    }
    
}
