//
//  LanguagesViewController.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa

class LanguagesViewController: NSViewController {
        
    @IBOutlet weak var tableView: NSTableView!
    
    var onLanguageSelect : ((Languages) -> ())?
    
    private var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(hex: 0x262626).cgColor
        self.tableView.backgroundColor = NSColor(hex: 0x262626)
        self.tableView.reloadData()
    }
    
}

extension LanguagesViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cell: LanguageTableCellView = self.tableView.makeView(withIdentifier: .init(String(describing: LanguageTableCellView.self)), owner: nil) as! LanguageTableCellView
        
        cell.setup(item: languages[row])
        cell.isSelected = selectedIndex == row
        
        cell.applySelectedCell()
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let table = notification.object as? NSTableView else {
            return
        }
        let row = table.selectedRow
        selectedIndex = row
        self.onLanguageSelect?(languages[row].language)
        tableView.reloadData()
    }
    
}
