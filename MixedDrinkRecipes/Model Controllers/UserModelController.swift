//
//  UserModelController.swift
//  MixedDrinkRecipes
//
//  Created by Alec Osborne on 5/12/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import Foundation
import CloudKit

class UserModelController {
    
    // MARK: - Singleton
    static let shared = UserModelController()
    
    
    // MARK: - Properties
    var loggedInUser: User?
    
    
    // MARK: - Methods
    func fetchCurrentUser(completion: @escaping(Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            
            if let error = error {
                print("Error fetching Apple Record ID: \(error)")
                completion(false)
                return
            }
            
            guard let appleUserRecordID = appleUserRecordID else { completion(false); return }
            
            let predicate = NSPredicate(format: "appleUserReference == %@", appleUserRecordID)
            
            CloudKitManager.shared.fetch(type: User.userTypeKey, predicate: predicate, completion: { (records, error) in
                
                if let error = error {
                    print("Error fetching users: \(error)")
                    completion(false)
                    return
                }
                
                guard let records = records,
                    let loggedInUserRecord = records.first,
                    let loggedInUser = User(ckRecord: loggedInUserRecord)
                    else { completion(false); return }
                
                self.loggedInUser = loggedInUser
                completion(true)
            })
        }
    }
    
    func createNewUserWith(emailAddress: String, firstName: String, lastName: String, completion: @escaping(Bool) -> Void) {
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            
            if let error = error {
                print("Error with the Apple ID: \(error)")
                completion(false)
                return
            }
            
            guard let appleUserRecordID = appleUserRecordID else { completion(false); return }
            
            let appleUserReference = CKReference(recordID: appleUserRecordID, action: .deleteSelf)
            
            let newUser = User(emailAddress: emailAddress, firstName: firstName, lastName: lastName, appleUserReference: appleUserReference)
            
            let record = CKRecord(user: newUser)
            
            CloudKitManager.shared.publicDataBase.save(record, completionHandler: { (_, error) in
                
                if let error = error {
                    print("Error saving new record to the database: \(error)")
                    completion(false)
                    return
                }
                
                self.loggedInUser = newUser
                completion(true)
            })
        }
    }
}
