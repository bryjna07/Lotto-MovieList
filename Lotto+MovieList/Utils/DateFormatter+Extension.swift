//
//  DateFormatter+Extension.swift
//  Lotto+MovieList
//
//  Created by YoungJin on 7/24/25.
//

import Foundation

extension DateFormatter {
    static let krDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    }()
}

extension Date {
    func dateToString(_ dateString: String = "yyyyMMdd") -> String? {
        let dateFormatter = DateFormatter.krDateFormatter
//        dateFormatter.dateFormat = dateString
        return dateFormatter.string(from: self)
    }
    
    /// 어제 날짜 구하기
    func calculateYesterDay() -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul") ?? .current
        let yesterDay = calendar.date(byAdding: .day, value: -1, to: self)
        return yesterDay
    }
}
