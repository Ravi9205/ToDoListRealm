//
//  DataBaseManager.swift
//  ToDoListRealm
//
//  Created by Ravi Dwivedi on 17/04/23.
//

import Foundation
import RealmSwift

final class DataBaseManager{
    
    
    static let shared = DataBaseManager()
    
    private init(){}
    
    private var realm = try! Realm()
    
    func getDataBaseURL() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    //MARK:- Save contacts into Realm MONGO DB
    public func  saveContacts(contact:Contact){
        try! realm.write({
            realm.add(contact)
        })
    }
    
    //MARK:- Get all Save Contact Records
    public func getAllContacts() -> [Contact]{
        return Array(realm.objects(Contact.self))
    }
    
    //MARK:- update Contact Records
    public func updateContact(oldcontact:Contact,newContact:Contact){
        try! realm.write({
            oldcontact.firstName = newContact.firstName
            oldcontact.lastName =  newContact.lastName
        })
    }
    
    //MARK:- Delete Contact Records
    
    public func delegateContact(contact:Contact){
        try! realm.write({
            realm.delete(contact)
        })
    }
    
}
