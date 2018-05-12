//
//  CloudKitManager.swift
//  MixedDrinkRecipes
//
//  Created by Alec Osborne on 5/12/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    // MARK: - Singleton
    static let shared = CloudKitManager()
    
    
    // MARK: - Properties
    let publicDataBase = CKContainer.default().publicCloudDatabase
    
    
    // MARK: - Methods
    func fetch(type: String, predicate: NSPredicate, completion: @escaping([CKRecord]?, Error?) -> Void) {
        let query = CKQuery(recordType: type, predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: nil, completionHandler: completion)
    }
}
