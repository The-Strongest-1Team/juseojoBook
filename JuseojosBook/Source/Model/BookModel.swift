//
//  BookModel.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/13/25.
//

import Foundation

struct BookResponse: Decodable {
	let data: [BookData]
}

struct BookData: Decodable {
	let attributes: Book
}

struct Chapter: Decodable {
	let title: String
}

struct Book: Decodable {
	let title: String
	let author: String
	let pages: Int
	let release_date: String
	let dedication: String
	let summary: String
	let wiki: String
	let chapters: [Chapter]
}
