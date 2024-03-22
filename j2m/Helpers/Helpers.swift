//
//  Helpers.swift
//  testapp
//
//  Created by Revan Sadigli on 19.03.2024.
//

import Foundation
import Cocoa

func changeStringColorAndSize(_ string: String, color: NSColor, fontSize: CGFloat) -> NSMutableAttributedString {
    let font = NSFont.systemFont(ofSize: fontSize)

    let attributedString = NSMutableAttributedString(string: string, attributes: [.foregroundColor: color, .font: font])
    
    return attributedString
}
