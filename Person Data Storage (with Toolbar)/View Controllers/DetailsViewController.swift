//
//  DetailsViewController.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/21/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Cocoa

class DetailsViewController: NSViewController {
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var surnameTextField: NSTextField!
    @IBOutlet weak var ageTextField: NSTextField!
    @IBOutlet weak var ageStepper: NSStepper!
    @IBOutlet weak var propertiesTableView: NSTableView!
    @IBOutlet weak var deletePropertyButton: NSButton!
    
    @IBAction func onAddPropertyClicked(_ sender: Any) {
        customProperties.append(CustomProperty(id: String(RealmManager.GenerateNextPropertyId()), key: "Новое свойство", value: "Значение"))
        person.customProperties = customProperties
        RealmManager.updatePerson(person: person)
    }
    @IBAction func onDeletePropertyClicked(_ sender: Any) {
        customProperties.remove(at: propertiesTableView.selectedRow)
        person.customProperties = customProperties
        RealmManager.updatePerson(person: person)
        deletePropertyButton.isEnabled = false
    }
    @IBAction func onEndEditingKey(_ sender: Any) {
        person.customProperties = customProperties
        RealmManager.updatePerson(person: person)
        
    }
    @IBAction func onEndEditingValue(_ sender: Any) {
        person.customProperties = customProperties
        RealmManager.updatePerson(person: person)
    }
    
    
    @objc dynamic var person = Person()
    @objc dynamic var customProperties: [CustomProperty] = [CustomProperty]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageTextField.formatter = OnlyIntegerValueFormatter()
//        setupView()
        setupConforming()
        
        person.customProperties.forEach { (prop) in
            customProperties.append(prop)
        }
    }
    func setupView() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
    }
    func setupConforming() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        ageTextField.delegate = self
    }
    func setupPersonDetails(person: Person) {
        self.person = person
    }
}

extension DetailsViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        
        if table.selectedRow != -1 {
            deletePropertyButton.isEnabled = true
        }
        else {
            deletePropertyButton.isEnabled = false
        }
    }
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return CustomSelectedTableRow()
    }
}


extension DetailsViewController: NSTextFieldDelegate {
    func controlTextDidEndEditing(_ obj: Notification) {
        RealmManager.updatePerson(person: person)
    }
}

