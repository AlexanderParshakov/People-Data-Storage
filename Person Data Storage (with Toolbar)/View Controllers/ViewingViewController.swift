//
//  ViewingViewController.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/20/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Cocoa

class ViewingViewController: NSViewController {
    
    @IBOutlet weak var peopleTableView: NSTableView!
    @IBOutlet weak var propertiesTableView: NSTableView!
    
    @objc dynamic var people = [Person]()
    @objc dynamic var currentProperties = [CustomProperty]()
    
    @IBAction func onPeopleRowDoubleClick(_ sender: Any) {
        changeWorkArea()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        people = RealmManager.retrievePeople()
        
        propertiesTableView.delegate = self
    }
    
    func changeWorkArea() {
        guard let splitViewController = self.parent as? NSSplitViewController else { return }
        guard let viewController = self.storyboard?.instantiateController(withIdentifier: Constants.StoryboardIdentifiers.editingScreen) as? EditingViewController else { return }
        guard let sidebarViewController = self.parent?.children[0] as? SidebarViewController else { return }
        sidebarViewController.stylizeButton(named: sidebarViewController.viewButton, state: .standard)
        sidebarViewController.stylizeButton(named: sidebarViewController.editButton, state: .highlighted)
        
        viewController.preselectedId = peopleTableView.selectedRow
        let item = NSSplitViewItem(viewController: viewController)
        
        splitViewController.removeSplitViewItem(splitViewController.splitViewItems[1])
        splitViewController.addSplitViewItem(item)
    }
}

extension ViewingViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        if table == peopleTableView {
            if peopleTableView.selectedRow != -1 {
                currentProperties = people[peopleTableView.selectedRow].customProperties
            }
        }
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return CustomSelectedTableRow()
    }
}
