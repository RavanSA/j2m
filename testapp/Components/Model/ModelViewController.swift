//
//  ModelViewController.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa
import macOSThemeKit

class ModelViewController: NSViewController {

    @IBOutlet var modelTextView: NSTextView!
    
    private var popover = NSPopover()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(hex: 0x1F1F24).cgColor
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshItems), name: Notifications.didSelectLanguage, object: nil)
    }
    
    @objc func refreshItems(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any],
           let text = userInfo["model"] as? String {
            modelTextView.string = ""
            
            let attrStr = colorizeCode(text)
            modelTextView.textStorage?.setAttributedString(attrStr)
        }
    }
    
    func colorizeCode(_ code: String) -> NSAttributedString {
        let range = (code as NSString).range(of: code)
        let attributedString = changeStringColorAndSize(code, color: NSColor(hex: 0x41A1C0), fontSize: 15)
            
        let keywords: [String] = ["struct", "let", "var", "import", "Codable", "Int", "String", "Bool", "{", "}", "?"]
        
        let jsonModelWords = removeEmptyStringsAndNewlines(from: code).components(separatedBy: " ")

        var currentLocation = 0
        
        jsonModelWords.forEach { word in
            if let selectedKeyword = keywords.first(where: { word.contains($0) }) {
                let nsString = code as NSString
                let range = nsString.range(of: selectedKeyword, options: .literal, range: NSRange(location: currentLocation, length: nsString.length - currentLocation))
                
                if range.location != NSNotFound {
                    let trimmedString = nsString.substring(with: range).trimmingCharacters(in: .whitespacesAndNewlines)
                    attributedString.replaceCharacters(in: range, with: trimmedString)
                    
                    let newRange = NSRange(location: range.location, length: trimmedString.utf16.count)
                    
                    switch selectedKeyword {
                    case "struct":
                        let color = NSColor(hex: 0xFC5FA3)
                        attributedString.addAttribute(.foregroundColor, value: color, range: newRange)
                        break
                    case "let", "var":
                        let color = NSColor(hex: 0xFC5FA3)
                        attributedString.addAttribute(.foregroundColor, value: color, range: newRange)
                        break
                    case "import":
                        let color = NSColor(hex: 0xFC5FA3)
                        attributedString.addAttribute(.foregroundColor, value: color, range: newRange)
                        break
                    case "Codable":
                        let color = NSColor(hex: 0xD0A8FF)
                        attributedString.addAttribute(.foregroundColor, value: color, range: newRange)
                        break
                    case "Int", "String", "Bool":
                        let color = NSColor(hex: 0xD0A8FF)
                        attributedString.addAttribute(.foregroundColor, value: color, range: newRange)
                        break
                    case "{", "}", "?":
                        let color = NSColor(hex: 0xFFFFFF)
                        attributedString.addAttribute(.foregroundColor, value: color, range: newRange)
                        break
                    default:
                        let color = NSColor(hex: 0x41A1C0)
                        break
                    }
                                        
                    currentLocation = range.location + trimmedString.utf16.count
                }
            }
        }

        return attributedString
    }
    
    func removeEmptyStringsAndNewlines(from string: String) -> String {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        let filteredComponents = components.filter { !$0.isEmpty && $0 != "\n" }
        return filteredComponents.joined(separator: " ")
    }
    
    @IBAction func onSettingsClicked(_ sender: Any) {
        let storyboard = NSStoryboard(name: "Settings", bundle: nil)
        guard let settingsViewController = storyboard.instantiateController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            fatalError("Unable to instantiate SettingsViewController from the storyboard")
        }
        popover.contentViewController = settingsViewController
        popover.behavior = .transient
        popover.show(relativeTo: NSZeroRect, of: view, preferredEdge: .maxY)
    }
    
}
