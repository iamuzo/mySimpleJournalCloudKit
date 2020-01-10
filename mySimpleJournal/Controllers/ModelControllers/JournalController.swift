//
//  JournalController.swift
//  mySimpleJouranal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

class JournalController {

    //MARK:- Singletons
    static let sharedGlobalInstance = JournalController()
    
    //MARK:- Properties
    var journals: [Journal] = []
    
    //MARK:- CRUD Functions
    func createNewJournal(name: String) {
        let journal = Journal(name: name)
        journals.append(journal)
    }
    
    func deleteJournal(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
    }
    
    func addNewEntry(entry: Entry, toJournal journal: Journal) {
        journal.entries.append(entry)
    }
    
    func deleteEntry(entry: Entry, fromjournal journal: Journal) {
        if let index = journal.entries.firstIndex(of: entry) {
            journal.entries.remove(at: index)
        }
    }
    
    func updateEntry(updatedEntry: Entry, oldEntry: Entry, inJournal journal: Journal) {
        if let index = journal.entries.firstIndex(of: oldEntry) {
            var entryToUpdate = journal.entries[index]
            if entryToUpdate == oldEntry {
                
                entryToUpdate = updatedEntry
            }
        }
    }
}
