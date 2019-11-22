//
//  SidebarViewController.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/18/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Cocoa

class SidebarViewController: NSViewController {
    
    @IBOutlet weak var viewButton: NSButton!
    @IBOutlet weak var editButton: NSButton!
    @IBOutlet weak var programInfoButton: NSButton!
    

    @IBAction func OnEditingButtonClicked(_ sender: NSButton) {
        changeWorkArea(storyboardIdentifier: Constants.StoryboardIdentifiers.editingScreen)
        stylizeButton(named: editButton, state: .highlighted)
        stylizeButton(named: viewButton, state: .standard)
        stylizeButton(named: programInfoButton, state: .standard)
    }
    @IBAction func OnViewingButtonClicked(_ sender: NSButton) {
        changeWorkArea(storyboardIdentifier: Constants.StoryboardIdentifiers.viewingScreen)
        stylizeButton(named: editButton, state: .standard)
        stylizeButton(named: viewButton, state: .highlighted)
        stylizeButton(named: programInfoButton, state: .standard)
    }
    @IBAction func onProgramInfoButtonClicked(_ sender: Any) {
        changeWorkArea(storyboardIdentifier: Constants.StoryboardIdentifiers.programInfoScreen)
        stylizeButton(named: editButton, state: .standard)
        stylizeButton(named: viewButton, state: .standard)
        stylizeButton(named: programInfoButton, state: .highlighted)
    }
    
    enum ButtonState {
        case standard
        case highlighted
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stylizeButton(named: viewButton, state: .standard)
        stylizeButton(named: editButton, state: .standard)
        stylizeButton(named: programInfoButton, state: .standard)
    }
    override func viewDidAppear() {
        changeWorkArea(storyboardIdentifier: Constants.StoryboardIdentifiers.viewingScreen)
        stylizeButton(named: viewButton, state: .highlighted)
    }
    
    func stylizeButton(named button: NSButton, state: ButtonState) {
        button.wantsLayer = true
        button.contentTintColor = .white
        
        if state == ButtonState.standard {
            button.layer?.backgroundColor = NSColor.systemGreen.cgColor
        }
        else if state == ButtonState.highlighted {
            button.layer?.backgroundColor = Constants.Colors.highlightGreen.cgColor
        }
    }
    func changeWorkArea(storyboardIdentifier id: String) {
        guard let splitViewController = self.parent as? NSSplitViewController else { return }
        guard let viewController = self.storyboard?.instantiateController(withIdentifier: id) as? NSViewController
                else { return }
        
        let item = NSSplitViewItem(viewController: viewController)
        
        splitViewController.removeSplitViewItem(splitViewController.splitViewItems[1])
        splitViewController.addSplitViewItem(item)
    }
}
