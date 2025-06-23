//
//  DateFormatter++.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/23/25.
//

import Foundation

extension DateFormatter {
	static let yyyyMMdd: DateFormatter = {
		let formatter = DateFormatter()

		formatter.dateFormat = "yyyy-MM-dd"
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)

		return formatter
	}()

	static let MMMMdyyyy: DateFormatter = {
		let formatter = DateFormatter()

		formatter.dateFormat = "MMMM d, yyyy"
		formatter.locale = Locale(identifier: "en_US")

		return formatter
	}()
}
