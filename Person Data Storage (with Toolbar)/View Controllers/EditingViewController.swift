//
//  EditingViewController.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/19/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Cocoa
import RealmSwift

class EditingViewController: NSViewController {
    
    @IBOutlet weak var peopleTableView: NSTableView!
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var detailsButton: NSButton!
    @IBOutlet weak var deleteButton: NSButton!
    
    @IBAction func onRowDoubleClick(_ sender: Any) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    @IBAction func onAddButtonClicked(_ sender: Any) {
        people.append(Person(newId: RealmManager.GenerateNextPersonId()))
        RealmManager.persistRealmPeople(fromPeopleArray: people)
    }
    @IBAction func onDeleteButtonClicked(_ sender: Any) {
        people.remove(at: peopleTableView.selectedRow)
        RealmManager.persistRealmPeople(fromPeopleArray: people)
        disableDependentButtons()
    }
    
    
    @objc dynamic var people: [Person] = [Person]()
    var preselectedId: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defer {
            if let id = preselectedId {
                let ndx:IndexSet = [id]
                peopleTableView.selectRowIndexes(ndx, byExtendingSelection: false)
            }
        }
        
        people = RealmManager.retrievePeople()
        
        disableDependentButtons()
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?)
    {
        if segue.destinationController is DetailsViewController
        {
            let vc = segue.destinationController as? DetailsViewController
            vc?.setupPersonDetails(person: people[peopleTableView.selectedRow])
        }
    }
    func disableDependentButtons() {
        detailsButton.isEnabled = false
        deleteButton.isEnabled = false
    }
    func enableDependentButtons() {
        detailsButton.isEnabled = true
        deleteButton.isEnabled = true
    }
}


extension EditingViewController: NSTableViewDelegate, NSTableViewDataSource {
    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        if table.selectedRow != -1 {
            enableDependentButtons()
        }
        else {
            disableDependentButtons()
        }
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return CustomSelectedTableRow()
    }
}

