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
    
    //MARK:- Properties
    var journals: [Journal] = []
    let privateDB = CKContainer.default().privateCloudDatabase

    //MARK:- Singletons
    static let sharedGlobalInstance = JournalController()
    
    //MARK:- CRUD Functions
    func createJournalInstance(with name: String,
                               entry: String,
                               completion: @escaping(Result<Journal?, JournalError>) -> Void)
    {
        let journalInstance = Journal(name: name, entry: entry)
        
        let journalRecord = CKRecord(journal: journalInstance)
        
        privateDB.save(journalRecord) { (ckRecordOptionsal, errorOptional) in
            
            //handle error if error
            if let error = errorOptional {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.ckError(error)))
                return
            }
            
            //save record if no error
            guard let record = ckRecordOptionsal,
                let savedJournalRecord = Journal(ckRecord: record)
                else {
                    completion(.failure(.unableToUnWrapCKRecordObject))
                    return
            }
            
            self.journals.insert(savedJournalRecord, at: 0)
            completion(.success(savedJournalRecord))
            return
        }
    }
    
    func fetchJournals(completion: @escaping (Result<[Journal], JournalError>) -> Void) {
        let queryAllPredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: JournalKeys.recordtypeKey, predicate: queryAllPredicate)
        
        //Configure Query
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error fetching journals:", error.localizedDescription)
                completion(.failure(.ckError(error)))
                return;
            }
            
            guard let records = records
                else {
                    completion(.failure(.unableToUnWrapCKRecordObject))
                    return;
            }
            
            let journals = records.compactMap({ journal in
                Journal(ckRecord: journal)
            })
            self.journals = journals
            return completion(.success(self.journals))
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
}
