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
    
    //MARK:- Load Persisted JournalData
    init() {
        loadData()
    }
    
    //MARK:- CRUD Functions
    func createNewJournal(name: String) {
        let journal = Journal(name: name)
        journals.append(journal)
        saveData()
    }
    
    func deleteJournal(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveData()
    }
    
    func addNewEntry(entry: Entry, toJournal journal: Journal) {
        journal.entries.append(entry)
        saveData()
    }
    
    func deleteEntry(entry: Entry, fromjournal journal: Journal) {
        if let index = journal.entries.firstIndex(of: entry) {
            journal.entries.remove(at: index)
            saveData()
        }
    }
    
    func updateEntry(updatedEntry: Entry, oldEntry: Entry, inJournal journal: Journal) {
        if let index = journal.entries.firstIndex(of: oldEntry) {
            var entryToUpdate = journal.entries[index]
            if entryToUpdate == oldEntry {
                entryToUpdate = updatedEntry
                saveData()
            }
        }
    }
    
    //MARK:- Local Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = paths[0]
        let journalFileName = "mySimpleJournal.json"
        let journalFileURL = docDir.appendingPathComponent(journalFileName)
        return journalFileURL
    }
    
    func saveData() {
        let jEncoder = JSONEncoder()
        
        do {
            let journalData = try jEncoder.encode(journals)
            try journalData.write(to: fileURL())
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
        }
    }
    
    func loadData() {
        let jDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedJournals = try jDecoder.decode([Journal].self, from: data)
            self.journals = decodedJournals
        } catch {
            print("Error loading persistent store/decoding data in persistent store: \(error.localizedDescription)")
        }
    }
}
