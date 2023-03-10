//
//  Date+format.swift
//  News
//
//  Created by Philip on 11.03.2023.
//

import Foundation

extension Date {
    static func getFormatDate(_ inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: inputDate) else { return ""}
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}
