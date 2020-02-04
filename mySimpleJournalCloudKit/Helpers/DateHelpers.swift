//
//  DateHelpers.swift
//  mySimpleJouranal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation

extension Date {
    var timeAsString: String {
        let stringDate = DateFormatter.localizedString(from: self, dateStyle: .short, timeStyle: .short)
        return stringDate
    }
}
