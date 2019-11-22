//
//  RealmPerson.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/19/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmPerson: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var age: String = ""
    
    let customProperties: List<RealmCustomProperty> = List<RealmCustomProperty>()
    
    
    
    convenience init(person: Person) {
        self.init()
        
        self.id = person.id
        self.name = person.name
        self.surname = person.surname
        self.age = String(person.age)
        person.customProperties.forEach { (cProp) in
            self.customProperties.append(RealmCustomProperty(id: cProp.id, key: cProp.key, value: cProp.value))
        }
    }
}

class RealmCustomProperty: Object {
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
