//
//  Journal.swift
//  mySimpleJouranal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation
import CloudKit

class Journal: Codable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return(
            lhs.name == rhs.name
        )
    }
}

extension CKRecord {
    convenience init(journal: Journal) {
        self.init(recordType: JournalKeys.RecordTypeKey)
        setValue(journal.name, forKey: JournalKeys.NameKey)
    }
}

extension Journal {
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[JournalKeys.NameKey] as? String
        else { return nil }
        self.init(name: name)
    }
}

enum JournalKeys {
    static let RecordTypeKey = "Journal"
    fileprivate static let NameKey = "name"
}





//import Foundation
//import CloudKit
//
//class Journal: Codable {
//
//    var name: String
//    var entries: [Entry]
//
//    init(name: String, entries: [Entry] = [] ) {
//        self.name = name
//        self.entries = entries
//    }
//}
//
//extension Journal: Equatable {
//    static func == (lhs: Journal, rhs: Journal) -> Bool {
//        return(
//            lhs.name == rhs.name && lhs.entries == rhs.entries
//        )
//    }
//}
//
//extension CKRecord {
//    convenience init(journal: Journal) {
//        self.init(recordType: JournalKeys.RecordTypeKey)
//        setValue(journal.name, forKey: JournalKeys.NameKey)
//        setValue(journal.entries, forKey: JournalKeys.EntriesKey)
//    }
//}
//
//extension Journal {
//    convenience init?(ckRecord: CKRecord) {
//        guard let name = ckRecord[JournalKeys.NameKey] as? String,
//            let entries = ckRecord[JournalKeys.EntriesKey] as? Array<Any>
//        else { return nil }
//        self.init(name: name, entries: entries as! [Entry])
//    }
//}
//
//enum JournalKeys {
//    static let RecordTypeKey = "Journal"
//    fileprivate static let NameKey = "name"
//    fileprivate static let EntriesKey = "entries"
//}
