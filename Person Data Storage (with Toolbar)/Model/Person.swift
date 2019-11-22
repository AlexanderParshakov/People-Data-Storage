//
//  Person.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/18/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation
import RealmSwift

final class Person: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var age: Int = 0
    
    var customProperties: Array<CustomProperty> = Array<CustomProperty>()
    
    
    
    
    convenience init(realmPerson: RealmPerson) {
        self.init()
        
        self.id = realmPerson.id
        self.name = realmPerson.name
        self.surname = realmPerson.surname
        self.age = Int(realmPerson.age) ?? 0
        realmPerson.customProperties.forEach { (cProp) in
            self.customProperties.append(CustomProperty(id: cProp.id, key: cProp.key, value: cProp.value))
        }
    }
    convenience init(newId: Int) {
        self.init()
        
        self.id = String(newId)
    }
}

class CustomProperty: NSObject {
    @objc dynamic var id: String = ""
    @objc dynamic var key: String = ""
    @objc dynamic var value: String = ""
    
    convenience init(id: String, key: String, value: String) {
        self.init()
        self.id = id
        self.key = key
        self.value = value
    }
}
