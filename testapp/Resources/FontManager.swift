//
//  FontManager.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa

class FontManager: NSObject {

    static func mainFont(size: CGFloat) -> NSFont? {
        return NSFont(name: "Effra-Regular", size: size)
    }
    
    static func mainLightFont(size: CGFloat) -> NSFont? {
        return NSFont(name: "EffraLight-Regular", size: size)
    }
    
    static func mainBoldFont(size: CGFloat) -> NSFont? {
        return NSFont(name: "Effra-Bold", size: size)
    }
    
    static func mainMediumFont(size: CGFloat) -> NSFont? {
        return NSFont(name: "System Regular", size: size)
    }
    
    static func codeFont(size: CGFloat) -> NSFont? {
        return NSFont(name: "Droid Sans Mono", size: size)
    }
    
}
