//
//  FormatDate+String.swift
//  Magazine+369+Travel
//
//  Created by YoungJin on 7/15/25.
//

import Foundation

extension String {
    func formatDate() -> String {
        let forMatter = DateFormatter()
        forMatter.dateFormat = "yyyyMMdd"
        
        if let date = forMatter.date(from: self) {
            forMatter.dateFormat = "yyyy-MM-dd"
            return forMatter.string(from: date)
        } else { return "" }
    }
}
