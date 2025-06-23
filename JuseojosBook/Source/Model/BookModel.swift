//
//  BookModel.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/13/25.
//

import Foundation

struct BookResponse: Decodable {
	let data: [Book]
}

struct Chapter: Decodable {
	let title: String
}

struct Book: Decodable {
	let title: String
	let author: String
	let pages: Int
	let releaseDate: Date
	let dedication: String
	let summary: String
	let wiki: URL
	let chapters: [Chapter]

	private enum RootCodingKeys: String, CodingKey {
		case attributes
	}

	private enum AttributesCodingKeys: String, CodingKey {
		case title
		case author
		case pages
		case releaseDate = "release_date"
		case dedication
		case summary
		case wiki
		case chapters
	}

	init(from decoder: Decoder) throws {
		let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
		let attrContainer = try rootContainer.nestedContainer(keyedBy: AttributesCodingKeys.self, forKey: .attributes)

		title = try attrContainer.decode(String.self, forKey: .title)
		author = try attrContainer.decode(String.self, forKey: .author)
		pages = try attrContainer.decode(Int.self, forKey: .pages)
		releaseDate = try attrContainer.decode(Date.self, forKey: .releaseDate)
		dedication = try attrContainer.decode(String.self, forKey: .dedication)
		summary = try attrContainer.decode(String.self, forKey: .summary)
		wiki = try attrContainer.decode(URL.self, forKey: .wiki)
		chapters = try attrContainer.decode([Chapter].self, forKey: .chapters)
	}
}

struct IndexedBook: Decodable {
	let index: Int
	let title: String
	let author: String
	let pages: Int
	let releaseDate: Date
	let dedication: String
	let summary: String
	let wiki: URL
	let chapters: [Chapter]

	init(index: Int, book: Book) {
		self.index = index
		self.title = book.title
		self.author = book.author
		self.pages = book.pages
		self.releaseDate = book.releaseDate
		self.dedication = book.dedication
		self.summary = book.summary
		self.wiki = book.wiki
		self.chapters = book.chapters
	}
}
