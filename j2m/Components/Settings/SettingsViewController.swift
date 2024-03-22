//
//  SettingsViewController.swift
//  testapp
//
//  Created by Revan Sadigli on 19.03.2024.
//

import Cocoa

class SettingsViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var closeBtn: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.headerView?.frame = NSRect(x: 0, y: 0, width: 0, height: 0)
        
        let gestureRecognizer = NSClickGestureRecognizer(target: self, action: #selector(imageViewClicked))
        closeBtn.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func imageViewClicked() {
        self.dismiss(nil)
    }
    
}

extension SettingsViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift]?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cellIdentifier = NSUserInterfaceItemIdentifier("CustomCell")
        
        guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? SettingsCustomTableViewCell else {
            return nil
        }
        
        cellView.settingsDescription.stringValue = settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift]?[row].description ?? ""
        cellView.checkBox.tag = row
        cellView.checkBox.state = NSControl.StateValue(0)
        cellView.checkBox.target = self
        cellView.checkBox.action = #selector(switchStateChanged(_:))
        
        return cellView
    }
        
    @objc func switchStateChanged(_ sender: NSButton) {
        let rowIndex = sender.tag
        if ParserController.shared.selectedLanguage == .swift {
            switch rowIndex {
            case 0:
                if sender.state == .on {
                    ParserController.shared.swiftOptionForCodingKeys = true
                } else {
                    ParserController.shared.swiftOptionForCodingKeys = false
                }
                break
            case 1:
                if sender.state == .on {
                    ParserController.shared.swiftOptionForVarOrLet = true
                } else {
                    ParserController.shared.swiftOptionForVarOrLet = false
                }
                break
            case 2:
                if sender.state == .on {
                    ParserController.shared.swiftOptionForOptional = true
                } else {
                    ParserController.shared.swiftOptionForOptional = false
                }
                break
            default:
                print("defaultswitch")
            }
        }
    }
    
}
