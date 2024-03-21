//
//  SettingsViewController.swift
//  testapp
//
//  Created by Revan Sadigli on 19.03.2024.
//

import Cocoa

class SettingsViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SettingsViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
            return settingsOptionForSwift.count
        }

        func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let cellIdentifier = NSUserInterfaceItemIdentifier("CustomCell")
            guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? SettingsCustomTableViewCell else {
                return nil
            }
            
            cellView.settingsDescription.stringValue = settingsOptionForSwift[row].description
            cellView.checkBox.tag = row
            cellView.checkBox.state = NSControl.StateValue(1)
            cellView.checkBox.target = self
            cellView.checkBox.action = #selector(switchStateChanged(_:))
            
            return cellView
        }

        // MARK: - Actions

        @objc func switchStateChanged(_ sender: NSButton) {
            let rowIndex = sender.tag
            if sender.state == .on {
                print("onofftestON")
            } else {
                print("onofftestOFF")
            }
        }
}
