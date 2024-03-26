//
//  JsonViewController.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa
import macOSThemeKit

class JsonViewController: NSViewController {

    @IBOutlet weak var jsonTextView: NSTextView!
    @IBOutlet weak var structName: NSTextField!
    
    var onJsonChangeText: ((String, String?) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(hex: 0x1F1F24).cgColor
        jsonTextView.delegate = self
    }
    
    func colorizeJSONString(_ jsonString: String) -> NSAttributedString? {
        let attributedString = changeStringColorAndSize(jsonString, color: NSColor(hex: 0x889999), fontSize: 15)
        let jsonKeyColor = NSColor(hex: 0x268ad1)
        let jsonValueColor = NSColor(hex: 0x2aa198)
        
        do {
            if let jsonObject = try parseJSONString(jsonString) {
                colorizeJSON(jsonObject, attributedString: attributedString, jsonKeyColor: jsonKeyColor, jsonValueColor: jsonValueColor)
            }
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
        
        return attributedString
    }
    
    func parseJSONString(_ jsonString: String) throws -> Any? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw NSError(domain: "Invalid JSON string", code: 0, userInfo: nil)
        }
        
        return try JSONSerialization.jsonObject(with: jsonData, options: [])
    }
    
    func colorizeJSON(_ jsonObject: Any, attributedString: NSMutableAttributedString, jsonKeyColor: NSColor, jsonValueColor: NSColor) {
                
        switch jsonObject {
        case let dict as [String: Any]:
            for (key, value) in dict {
                let keyRange = (attributedString.string as NSString).range(of: "\"\(key)\"")
                attributedString.addAttribute(.foregroundColor, value: jsonKeyColor, range: keyRange)
                colorizeJSON(value, attributedString: attributedString, jsonKeyColor: jsonKeyColor, jsonValueColor: jsonValueColor)
            }
        case let array as [Any]:
            for element in array {
                if let nestedDict = element as? [String: Any] {
                    colorizeJSON(nestedDict, attributedString: attributedString, jsonKeyColor: jsonKeyColor, jsonValueColor: jsonValueColor)
                } else if let nestedArray = element as? [Any] {
                    colorizeJSON(nestedArray, attributedString: attributedString, jsonKeyColor: jsonKeyColor, jsonValueColor: jsonValueColor)
                } else if let valueString = "\(element)" as? NSString {
                    let valueRange = (attributedString.string as NSString).range(of: valueString as String)
                    attributedString.addAttribute(.foregroundColor, value: jsonValueColor, range: valueRange)
                }
            }
        default:
            break
        }
    }

    @IBAction func cleanJsonText(_ sender: Any) {
        jsonTextView.string = ""
    }
    
    @IBAction func structNameAction(_ sender: Any) {
        onJsonChangeText?(jsonTextView.string, structName.stringValue)
    }
    
}

extension JsonViewController: NSTextViewDelegate {
    func textDidChange(_ notification: Notification) {
        if let attributedJSON = colorizeJSONString(jsonTextView.string) {
            onJsonChangeText?(jsonTextView.string, structName.stringValue)
            jsonTextView.textStorage?.setAttributedString(attributedJSON)
        }
    }
}
