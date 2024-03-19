//
//  ViewController.swift
//  testapp
//
//  Created by Revan Sadigli on 13.03.2024.
//

import Cocoa
import macOSThemeKit

class ViewController: NSViewController {

    var languageViewController: LanguagesViewController?
    var jsonViewController: JsonViewController?
    var modelViewController: ModelViewController?
    
    @IBOutlet weak var modelBox: NSBox!
    @IBOutlet weak var jsonBox: NSBox!
    @IBOutlet weak var languageBox: NSBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.modelBox.fillColor = ThemeColor.projectListBackgroundColor
        self.languageBox.fillColor = ThemeColor.deviceListBackgroundColor
        self.jsonBox.fillColor = ThemeColor.packetListAndDetailBackgroundColor
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
                print("strviewvc", structName)
                ParserController.shared.jsonText = jsonText
                ParserController.shared.structName = structName
            }
            
//            self.projectsViewController?.viewModel?.register()
            
//            self.projectsViewController?.onProjectSelect = { (selectedProjectController) in
//
//                BagelController.shared.selectedProjectController = selectedProjectController
//            }
            
        }
        
        if let destinationVC = segue.destinationController as? ModelViewController {
            
            self.modelViewController = destinationVC
//            self.projectsViewController?.viewModel?.register()
            
//            self.projectsViewController?.onProjectSelect = { (selectedProjectController) in
//
//                BagelController.shared.selectedProjectController = selectedProjectController
//            }
            
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

