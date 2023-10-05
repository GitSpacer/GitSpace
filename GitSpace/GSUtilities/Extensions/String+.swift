//
//  String+.swift
//  GitSpace_Utilities
//
//  Created by Celan on 2023/10/05.
//

import Foundation

public extension String {
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else { return Date() }
        return date
    }
}
