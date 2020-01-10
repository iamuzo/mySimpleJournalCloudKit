//
//  Journal.swift
//  mySimpleJouranal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

class Journal: Codable {
    
    var name: String
    var entries: [Entry]
    
    init(name: String, entries: [Entry] = [] ) {
        self.name = name
        self.entries = entries
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return(
            lhs.name == rhs.name && lhs.entries == rhs.entries
        )
    }
}
