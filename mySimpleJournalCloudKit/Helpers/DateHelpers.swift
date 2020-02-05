//
//  DateHelpers.swift
//  mySimpleJouranal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

extension Date {
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
