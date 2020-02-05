//
//  JournalError.swift
//  mySimpleJournal
//
//  Created by Uzo on 2/4/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

enum JournalError: LocalizedError {
    case ckError(Error)
    case unableToUnWrapCKRecordObject
    
    var errorDescription: String? {
        switch self {
            case .ckError(let error):
                return error.localizedDescription
            case .unableToUnWrapCKRecordObject:
                return "unable to unwrap or get journal object"
        }
    }
}
