//
//  Journal.swift
//  mySimpleJouranal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation
import CloudKit

enum JournalKeys {
    static let recordtypeKey = "Journal"
    fileprivate static let nameKey = "name"
    fileprivate static let entryKey = "entry"
    fileprivate static let timestampkey = "timestamp"
}

class Journal {
    
    var name: String
    var entry: String
    var timestamp: Date
    var recordID: CKRecord.ID
    
    init(name: String,
         entry: String,
         timestamp: Date = Date(),
         recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString))
    {
        self.name = name
        self.entry = entry
        self.timestamp = timestamp
        self.recordID = recordID
    }
}

extension Journal {
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[JournalKeys.nameKey] as? String,
            let entry = ckRecord[JournalKeys.entryKey] as? String,
            let timestamp = ckRecord[JournalKeys.timestampkey] as? Date
        else { return nil }
        
        self.init(name: name, entry: entry, timestamp: timestamp, recordID: ckRecord.recordID)
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return(lhs === rhs)
    }
}

extension CKRecord {
    convenience init(journal: Journal) {
        self.init(recordType: JournalKeys.recordtypeKey, recordID: journal.recordID)
        self.setValuesForKeys([
            JournalKeys.nameKey : journal.name,
            JournalKeys.entryKey : journal.entry,
            JournalKeys.timestampkey : journal.timestamp
        ])
    }
}
