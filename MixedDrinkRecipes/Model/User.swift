//
//  User.swift
//  MixedDrinkRecipes
//
//  Created by Alec Osborne on 5/12/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    static let userTypeKey = "User"
    fileprivate static let appleUserReferenceKey = "appleUserReference"
    fileprivate static let emailKey = "email"
    fileprivate static let firstNameKey = "firstName"
    fileprivate static let lastNameKey = "lastName"
    
    let email: String
    let firstName: String
    let lastName: String
    
    var cloudKitRecordID: CKRecordID?
    let appleUserReference: CKReference
    
    init(email: String, firstName: String, lastName: String, appleUserReference: CKReference) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.appleUserReference = appleUserReference
    }
    
    init?(ckRecord: CKRecord) {
        guard let email = ckRecord[User.emailKey] as? String,
                let firstName = ckRecord[User.firstNameKey] as? String,
                let lastName = ckRecord[User.lastNameKey] as? String,
                let appleUserReference = ckRecord[User.appleUserReferenceKey] as? CKReference
            else { return nil }
        
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.appleUserReference = appleUserReference
        
        self.cloudKitRecordID = ckRecord.recordID
    }
}

extension CKRecord {
    convenience init(user: User) {
        let recordID = user.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: User.userTypeKey, recordID: recordID)
        self.setValue(user.email, forKey: User.emailKey)
        self.setValue(user.firstName, forKey: User.firstNameKey)
        self.setValue(user.lastName, forKey: User.lastNameKey)
        self.setValue(user.appleUserReference, forKey: User.appleUserReferenceKey)
        
        user.cloudKitRecordID = recordID
    }
}
