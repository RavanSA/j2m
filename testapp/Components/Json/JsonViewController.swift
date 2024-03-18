//
//  JsonViewController.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa
import macOSThemeKit

class JsonViewController: NSViewController {

    @IBOutlet var jsonTextView: NSTextView!
    
    var onJsonChangeText: ((String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(hex: 0x3A3A3A).cgColor
        jsonTextView.delegate = self
    }
    
    // Function to colorize JSON key-value pairs
    func colorizeJSONString(_ jsonString: String) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: jsonString)
        let jsonKeyColor = NSColor.blue // Set your desired color for JSON keys
        let jsonValueColor = NSColor.red // Set your desired color for JSON values
        
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
    
    // Function to parse JSON string
    func parseJSONString(_ jsonString: String) throws -> Any? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw NSError(domain: "Invalid JSON string", code: 0, userInfo: nil)
        }
        
        return try JSONSerialization.jsonObject(with: jsonData, options: [])
    }
    
    // Recursive function to colorize JSON key-value pairs
    func colorizeJSON(_ jsonObject: Any, attributedString: NSMutableAttributedString, jsonKeyColor: NSColor, jsonValueColor: NSColor) {
        switch jsonObject {
        case let dict as [String: Any]:
            for (key, value) in dict {
                let keyRange = (attributedString.string as NSString).range(of: "\"\(key)\"")
                attributedString.addAttribute(.foregroundColor, value: jsonKeyColor, range: keyRange)
                colorizeJSON(value, attributedString: attributedString, jsonKeyColor: jsonKeyColor, jsonValueColor: jsonValueColor)
            }
        case let array as [Any]:
            for (index, value) in array.enumerated() {
                let valueString = "\(value)"
                let valueRange = (attributedString.string as NSString).range(of: valueString)
                attributedString.addAttribute(.foregroundColor, value: jsonValueColor, range: valueRange)
                if valueString.starts(with: "{") || valueString.starts(with: "[") {
                    colorizeJSON(value, attributedString: attributedString, jsonKeyColor: jsonKeyColor, jsonValueColor: jsonValueColor)
                }
            }
        default:
            break
        }
    }
    
    @IBAction func cleanJsonText(_ sender: Any) {
        jsonTextView.string = ""
    }
    
}

extension JsonViewController: NSTextViewDelegate {
    func textDidChange(_ notification: Notification) {
        if let textView = notification.object as? NSTextView {
            onJsonChangeText?(textView.string)
            jsonTextView.string = textView.string
//            if let attributedJSON = colorizeJSONString(textView.string) {
//                        // Display the colorized JSON string in the text view
//                        jsonTextView.textStorage?.setAttributedString(attributedJSON)
//                    }
         }
    }
}
