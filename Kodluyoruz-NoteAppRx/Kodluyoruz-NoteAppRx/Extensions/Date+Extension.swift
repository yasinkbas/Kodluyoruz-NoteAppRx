//
//  Date+Extension.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 14.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import Foundation

extension Date {
    func string(dateFormat: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.string(from: self)
    }
}

enum DateFormat: String {
    case ddMMyyyy = "dd/MM/yyyy"
    case ddMMyyyyWithDot = "dd.MM.yyyy"
    case yyyyMMdd = "yyyy/MM/dd"
    case yyyyMMddWithDot = "yyyy.MM.dd"
}
