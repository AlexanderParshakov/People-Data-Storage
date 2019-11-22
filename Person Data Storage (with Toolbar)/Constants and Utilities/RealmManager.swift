//
//  RealmManager.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/19/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmManager {
    
    static let schemaVersion: UInt64 = 8
    static func printPath() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    static func persistRealmPeople(fromPeopleArray people: [Person]) {

        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < RealmManager.schemaVersion) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        var realmPeople = [RealmPerson]()
        people.forEach { (person) in
            realmPeople.append(RealmPerson(person: person))
        }
        try! realm.write {
            realm.delete(realm.objects(RealmPerson.self))
            realm.delete(realm.objects(RealmCustomProperty.self))
            realm.add(realmPeople)
        }
    }
    static func retrievePeople() -> [Person] {
        let config = Realm.Configuration(
                    schemaVersion: schemaVersion,
                    migrationBlock: { migration, oldSchemaVersion in
                        if (oldSchemaVersion < RealmManager.schemaVersion) {
                        }
                    })
                Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        var persons = [Person]()
        
        let realmPersonResults = realm.objects(RealmPerson.self)
        realmPersonResults.forEach { (realmPerson) in
            persons.append(Person(realmPerson: realmPerson))
        }
        
        return persons
    }
    static func updatePerson(person: Person) {
        let realm = try! Realm()
        let peopleById = realm.objects(RealmPerson.self).filter("id == '" + person.id + "'") // always one
        if let updatablePerson = peopleById.first {
            let realmPerson = RealmPerson(person: person)
            try! realm.write {
                updatablePerson.name = realmPerson.name
                updatablePerson.surname = realmPerson.surname
                updatablePerson.age = realmPerson.age
                
                realm.delete(updatablePerson.customProperties)
                updatablePerson.customProperties.removeAll()
                realmPerson.customProperties.forEach { (realmProp) in
                    updatablePerson.customProperties.append(realmProp)
                }
            }
        }
    }
    static func GenerateNextPersonId() -> Int {
        let realm = try! Realm()
        
        let persons = realm.objects(RealmPerson.self)
        
        if persons.count > 0 {
            return persons.map{Int($0.id)!}.max()! + 1
        }
        else if persons.count == 0 {
            return 0
        }
        return 0
    }
    static func GenerateNextPropertyId() -> Int {
        let realm = try! Realm()
        
        let properties = realm.objects(RealmCustomProperty.self)
        
        if properties.count > 0 {
            return properties.map{Int($0.id)!}.max()! + 1
        }
        else if properties.count == 0 {
            return 0
        }
        return 0
    }
}
