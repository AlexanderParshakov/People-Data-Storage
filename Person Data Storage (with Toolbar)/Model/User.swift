//
//  User.swift
//  Person Data Storage (with Toolbar)
//
//  Created by Alexander Parshakov on 11/18/19.
//  Copyright © 2019 Alexander Parshakov. All rights reserved.
//

import Foundation

struct User {
    var login       : String
    var password    : String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    func signIn() -> Bool {
        if self == Constants.HostUser { return true }
        else { return false }
    }
}

// MARK: - Implementing Custom Comparable for User struct
func == (lhs: User, rhs: User) -> Bool {
    return lhs.login == rhs.login && lhs.password == rhs.password
}
