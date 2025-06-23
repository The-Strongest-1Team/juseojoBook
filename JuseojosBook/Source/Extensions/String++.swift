//
//  String++.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/23/25.
//

extension String {
	func summary(until: Int) -> String {
		if self.count >= until {
			return self.prefix(until) + "..."
		}

		return self
	}
}
