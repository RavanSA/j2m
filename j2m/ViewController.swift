//
//  ViewController.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa

class ViewController: NSViewController {

    var languageViewController: LanguagesViewController?
    var jsonViewController: JsonViewController?
    var modelViewController: ModelViewController?
    
    @IBOutlet weak var modelBox: NSBox!
    @IBOutlet weak var jsonBox: NSBox!
    @IBOutlet weak var languageBox: NSBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.modelBox.fillColor = ThemeColor.modelBoxColor
        self.languageBox.fillColor = ThemeColor.languageBox
        self.jsonBox.fillColor = ThemeColor.jsonBox
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destinationController as? LanguagesViewController {
            self.languageViewController = destinationVC
            self.languageViewController?.onLanguageSelect = { (language) in
                ParserController.shared.selectedLanguage = language
            }
        }
        
        if let destinationVC = segue.destinationController as? JsonViewController {
            self.jsonViewController = destinationVC
            self.jsonViewController?.onJsonChangeText = { (jsonText, structName) in
                ParserController.shared.jsonText = jsonText
                ParserController.shared.structName = structName
            }
        }
        
        if let destinationVC = segue.destinationController as? ModelViewController {
            self.modelViewController = destinationVC
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

