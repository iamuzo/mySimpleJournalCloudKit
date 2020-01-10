//
//  Entry.swift
//  mySimpleJouranal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

class Entry: Codable {
    
    var title: String
    var text: String
    var timeStamp: Date
    
    init(title: String, text: String, timeStamp: Date = Date()) {
        self.title = title
        self.text = text
        self.timeStamp = timeStamp
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return(
            lhs.title == rhs.title &&
                lhs.text == rhs.text &&
                lhs.timeStamp == rhs.timeStamp
        )
    }
}
