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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(hex: 0x3A3A3A).cgColor
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshItems), name: Notifications.didSelectLanguage, object: nil)
    }
    
    @objc func refreshItems(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any],
           let text = userInfo["model"] as? String {
            modelTextView.string = ""
            modelTextView.string = text
        }
    }
    
}
