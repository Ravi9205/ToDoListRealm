//
//  Contact.swift
//  ToDoListRealm
//
//  Created by Ravi Dwivedi on 15/04/23.
//

import Foundation
import RealmSwift

class Contact:Object {

   @Persisted var firstName:String
   @Persisted var lastName:String
    
   convenience init(_firstName:String,_lastName:String) {
       self.init()
       self.firstName = _firstName
       self.lastName = _lastName
   }
}
