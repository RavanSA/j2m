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
        let item = settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift]?[row]
        
        cellView.settingsDescription.stringValue = item?.description ?? ""
        cellView.checkBox.tag = row
        cellView.checkBox.state = NSControl.StateValue(item?.currentState == true ? 1 : 0)
        cellView.checkBox.target = self
        cellView.checkBox.action = #selector(switchStateChanged(_:))
        
        return cellView
    }
        
    @objc func switchStateChanged(_ sender: NSButton) {
        let rowIndex = sender.tag
        if ParserController.shared.selectedLanguage ?? .swift == .swift {
            switch rowIndex {
            case 0:
                ParserController.shared.swiftOptions.codingKeys = sender.state == .on
                if var settingsOption = settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift] {
                    if let index = settingsOption.firstIndex(where: { $0.id == 1 }) {
                        settingsOption[index].changeCurrentState(isActive: sender.state == .on)
                        settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift] = settingsOption
                    }
                }
            case 1:
                ParserController.shared.swiftOptions.varOrLet = sender.state == .on
                if var settingsOption = settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift] {
                    if let index = settingsOption.firstIndex(where: { $0.id == 2 }) {
                        settingsOption[index].changeCurrentState(isActive: sender.state == .on)
                        settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift] = settingsOption
                    }
                }
            case 2:
                ParserController.shared.swiftOptions.optionalProperties = sender.state == .on
                if var settingsOption = settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift] {
                    if let index = settingsOption.firstIndex(where: { $0.id == 3 }) {
                        settingsOption[index].changeCurrentState(isActive: sender.state == .on)
                        settingsOptionForSwift[ParserController.shared.selectedLanguage ?? .swift] = settingsOption
                    }
                }
            default:
                break
            }
        }
    }
    
}
