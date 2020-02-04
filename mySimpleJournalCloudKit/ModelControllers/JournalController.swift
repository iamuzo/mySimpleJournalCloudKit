//
//  JournalController.swift
//  mySimpleJouranal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation
import CloudKit

class JournalController {

    //MARK:- Singletons
    static let sharedGlobalInstance = JournalController()
    
    //MARK:- Properties
    var journals: [Journal] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    //MARK:- CRUD Functions
    func createNewJournal(name: String, completion: @escaping (Bool) -> Void) {
        let journal = Journal(name: name)
        let journalRecord = CKRecord(journal: journal)
        
        privateDB.save(journalRecord) { (record, error) in
            if let error = error {
                print("Error saving to database:", error.localizedDescription)
                return completion(false)
            }
            
            self.journals.append(journal)
            return completion(true)
        }
    }
    
    func deleteJournal(journal: Journal, completion: @escaping (Bool) -> Void) {
        let recordID = CKRecord(journal: journal).recordID
        
        privateDB.delete(withRecordID: recordID) { (recordID, error) in
            if let error = error {
                print("Error deleting:", error.localizedDescription)
                return completion(false)
            }
            
            guard recordID != nil,
                let index = self.journals.firstIndex(of: journal)
                else { return completion(false)}
            // Removing the deleted contact
            self.journals.remove(at: index)
            print(self.journals)
            
            return completion(true)
        }
    
    }
    
    func fetchJournals(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: JournalKeys.RecordTypeKey, predicate: predicate)
        
        //Configure Query
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching journals:", error.localizedDescription)
                return completion(false)
            }
            guard let records = records else {return completion(false)}
            let journals = records.compactMap({ journal in
                Journal(ckRecord: journal)
            })
            self.journals = journals
            return completion(true)
        }
    }
}
