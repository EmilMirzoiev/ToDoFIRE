//
//  User.swift
//  ToDoFIRE
//
//  Created by Emil on 11.03.23.
//

import Foundation
import Firebase

struct UserModel {
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email ?? ""
    }
}
